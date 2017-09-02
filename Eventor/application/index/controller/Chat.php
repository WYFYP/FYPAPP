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

use app\index\model\Chat as ChatModel;



class Chat extends Controller {
    // 发消息
    public function send()
    {
        $result = array('code' => '-1','msg'=>'未知错误','rows' => array()); 
        if(session("?uid")){
            if(input("?eid")){ 
                $chat = new ChatModel(input());
                $chat->uid = session("uid");
                $chat->nick = session("nickname");
                $chat->avatar = session("avatar")||"";
                if ($id = $chat->allowField(true)->save()) {
                    $result['code'] = '0';
                    $result['msg'] = '发布成功';
                    $result['data'] =  $chat;
                } else {
                    $result['msg'] = '发布失败';
                }
            }else{
                $result['msg'] = '缺少参数';
            }
        }else{
            $result['code'] = '1001';
            $result['msg'] = '尚未登录';
        }       
        return json_encode($result);
    }

   

    //chat group
    public function group(){
        $result = array('code' => '-1','msg'=>'未知错误'); 
        if(session("?uid")){

            $eventList = StateModel::where([
                "uid"=>["=",session("uid")],
                "chat"=>["=",1]
            ])->column('eid');
            $result['$eventList'] = json_encode($eventList);
            
            if($eventList){
                $chatGroup = EventModel::all($eventList);
                $result["data"] = $chatGroup;
            }else{
                $result["data"] = [];
            }
            
            $result['code'] = '0';
            $result["msg"] = "获取成功"  ;   
               
        }else{
            $result['code'] = '1001';
            $result['msg'] = '尚未登录';
        }       
        return json_encode($result);
    }

    //chat history
    public function history(){
        $result = array('code' => '-1','msg'=>'未知错误'); 
        if(session("?uid")){
            if(input("?eid")){
                $chatlist = new ChatModel();
                $where = array();
                $order = array();
                $sort["id"] ="esc";
                $where["eid"] = array("=",input("eid"));
                $rows = $chatlist->where($where)->order($sort)->SELECT();
                $result["data"] = $rows;
                $result['code'] = '0';
                $result["msg"] = "获取成功"  ;       
            }else{
                $result['msg'] = '缺少参数';
            }
        }else{
            $result['code'] = '1001';
            $result['msg'] = '尚未登录';
        }       
        return json_encode($result);
    }
}