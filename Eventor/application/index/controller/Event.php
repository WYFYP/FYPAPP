<?php

namespace app\index\controller;

use think\Db;
use think\Session;
use think\Request;
use think\Controller;
use org\Upload;

use app\index\model\Event as EventModel;
use app\index\model\User as UserModel;
use app\index\model\State as StateModel;



class Event extends Controller {
    //发布活动
    public function publish()
    {
        $result = array('code' => '-1','msg'=>'未知错误','rows' => array()); 
        if(session("?uid")){
            if ($this->request->isPost()) {
                $event = new EventModel(input());
                $event->uid = session("uid");
                $event->nick = session("nickname");
                if ($id = $event->allowField(true)->save()) {
                    $result['code'] = '0';
                    $result['msg'] = '发布成功';
                    $result['row'] =  $event;
                } else {
                    $result['msg'] = '发布失败';
                }
            } else {
                $result['msg'] = '请求方式错误';
            }
        }else{
            $result['code'] = '1001';
            $result['msg'] = '尚未登录';
        }       
        return json_encode($result);
    }

    //
    public function info()
    {
        $result = array('code' => '-1','msg'=>'未知错误','rows' => array()); 
        if(session("?uid")){
            if (input("?eid")) {
                $event =    EventModel::get(input("eid"));
                if($event){
                     $result['row'] = $event;
                     $result['code'] = 0;
                     $result['msg'] = '获取成功';
                }else{
                     $result['msg'] = 'Event 不存在';
                }
            } else {
                $result['msg'] = '缺少参数“event id”';
            }
        }else{
            $result['code'] = '1001';
            $result['msg'] = '尚未登录';
        }       
        return json_encode($result);
    }


    //
    public function search(){
        $result = array('code' => '-1','msg'=>'未知错误'); 
        if(session("?uid")){
            $eventlist = new EventModel();
            
            $where = array();
            if(input("?kw")){
                $likekw ="%".input("kw")."%";
                $where["title|description|location|category|organizer"] =array("like",$likekw);
            }
            if(input("?uid")){$where["uid"] = input("uid");};
            if(input("?category")){$where["category"] = input("category");}


            $sort = array();
            if(input("?like")){$sort["like"] = input("like");};
            if(input("?join")){$sort["join"] = input("join");};
            if(input("?start")){$sort["start"] = input("start");};

            $sort["id"] ="desc";
            $result["input"] =json_encode(input());
            // $result["query"] =json_encode( $where);

            $size =input("?size")?input("size"):10;

            $pageInfo = $eventlist->where($where)->order($sort)->paginate($size);

            $result['code'] = '0';
            $result['msg'] = '查询成功';
            $result["result"] = $pageInfo; 
        
        }else{
            $result['code'] = '1001';
            $result['msg'] = '尚未登录';
        }       
        return json_encode($result);
    }




  


    //更新、查询State
    public function state(){
        $result = array('code' => '-1','msg'=>'未知错误');
        $st = null;
        if(input("?eid") && session("?uid")){
            $state =   StateModel::get([
                "eid"=>["=",input("eid")],
                "uid"=>["=",session("uid")]
            ]);

            $event = EventModel::get(["id"=>input("eid")]);
            if( $state ){
                if( input("?like") || input("?join") || input("?chat") ){

                    if(input("?chat")){ $state["chat"] =  (bool)input("chat") ;};
                    if(input("?like")){
                        if(input("like")=="1"  ){
                            if( $state["like"] != 1){
                                $event->like =  $event->like +1;
                            }
                        }else{
                            $event->like =  $event->like -1;
                            if($event->like <0){
                                $event->like = 0;
                            }
                        }
                        $state["like"] =  (bool)input("like");
                    };
                    if(input("?join")){
                        if(input("join")=="1" ){
                            if($state["join"] != 1){
                                if($event->join < $event->max){
                                    $event->join =  $event->join+1;
                                }else{
                                    $result["msg"] = "报名已满";
                                    return json_encode($result);
                                }
                            }
                        }else{
                            $event->join =  $event->join-1;
                            if($event->join <0){
                                $event->join = 0;
                            }
                        }   
                        $state["join"] =  (bool)input("join") ;
                    };
                    $result["update"] = "111";
                    $state->save(); 
                }
            }else{
               
                if( input("?like") || input("?join") || input("?chat") ){
                   
                    $nst = array();
                    $nst["eid"] = input("eid");
                    $nst["uid"] = session("uid");

                    if(input("?chat")){$nst["chat"] =  (bool)input("chat") ;};
                    if(input("?like")){
                        $nst["like"] =  (bool)input("like") ;
                        if(input("like")== 1){
                            $event->like =  $event->like+1;
                        }
                    };
                    if(input("?join")){
                        $nst["join"] =  (bool)input("join") ;
                        if(input("join")==1){
                            if($event->join <= $event->max){
                                $event->join =  $event->join+1;
                            }else{
                                $result["msg"] = "报名已满";
                                return json_encode($result);
                            }
                        }
                        
                    };
                    $state = StateModel::create($nst);
                }else{
                    $state = array("chat"=>false,"like"=>false,"join"=>false);
                }
            }
            $event->save();
            $result['code'] = '0';
            $result["msg"] = "获取成功"  ; 
            $result["data"] = $state  ;             
        }else{
            if( session("?uid")){
                $result["msg"] = "缺少参数";
            }else{
                $result['code'] = '1001';
                $result['msg'] = '尚未登录';            
            }
        }
        return json_encode($result);
    }


      //上传文件示例
      public function upload($fileName='avatar'){
        $config = [
            'maxSize'      => 2048000,
            'exts'         => ['jpg','gif','png','jpeg'],
            'autoSub'      => true,
            'subName'      => ['date', 'Y-m-d'],
            'rootPath'     => './data/',
            'savePath'     => 'attachement/',
            'saveExt'      => 'jpg',
            'hash'         => true,
            'callback'     => true,
            'driver'       => 'Local',
        ];
        $uploader = new Upload($config);
        $info = $uploader->upload();
        if(!$info){
            echo $uploader->getError();
        }else{
            header("Content-type:image/jpeg");
            echo '/data/'.$info[$fileName]['savepath'].$info[$fileName]['savename'];
        }
    }
    


    
   
}