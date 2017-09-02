<?php
namespace app\index\controller;

use think\Db;
use think\Session;
use think\Request;
use think\Controller;

use app\index\model\Event as EventModel;
use app\index\model\User as UserModel;
use app\index\model\State as StateModel;

class User extends Controller {
     //用户注册
    public function register()
    {
        $result = array('code' => '-1','msg'=>'未知错误','rows' => array());   
        if ($this->request->isPost()) {
            $olduser = UserModel::get(['username' =>input('post.username')]);
            if( $olduser["id"] ){
                $result['msg'] = '用户名已存在';
            }else{
                $user = new UserModel(input());
                if ($id = $user->allowField(true)->save()) {
                    $result['code'] = '0';
                    $result['msg'] = '注册成功';
                    unset($user['password']);
                    $result['row'] =  $user;

                } else {
                    $result['msg'] = '注册失败';
                }
            }
        } else {
            $result['msg'] = '请求方式错误';
        }
        return json_encode($result);
    }
    
    //用户登录
    public function login()
    {
        $result = array('code' => '-1','msg'=>'未知错误'); 
        if ($this->request->isPost()) {   
            $user = UserModel::get(['username' =>input('post.username')]);
            if( $user["id"] ){
                if($user["password"] == md5(input("password"))){
                    $result['code'] = '0';
                    $result['msg'] = '登录成功';
                    unset($user['password']);
                    session('uid', $user["id"]);
                    session('username', $user["username"]);
                    session('nickname', $user["nickname"]);
                    session('avatar', $user["avatar"]||"");
                    
                    $result['row'] =  $user;
                }else{
                    $result['msg'] = '用户名或密码错误';
                }
            }else{
                $result['msg'] = '用户名或密码错误';
            }
        } else {
            $result['msg'] = '请求方式错误';
        }
        return json_encode($result);
    }

     //用户信息
    public function info()
    {
        $result = array('code' => '-1','msg'=>'未知错误');   
        if(session("?uid")){
            // 传参数，获取指定用户信息，不传获取自己的
            $uid =  1;
            if( input("uid")){
                $uid =   input("uid");
            }else{
                $uid =   session("uid");
            };
            $userInfo = UserModel::get(["id"=>$uid]);
            $result["data"] = $userInfo;
             $result["code"] = 0;
             $result["msg"] = "获取成功";
        }else{
            $result['code'] = '1001';
            $result['msg'] = '尚未登录';
        }
        return json_encode($result);
    }

     //指定用户创建的Event
     public function create()
     {
         $result = array('code' => '-1','msg'=>'未知错误');   
         if(session("?uid")){
             $uid =  1;
             if( input("uid")){
                 $uid =   input("uid");
             }else{
                 $uid =   session("uid");
             }
             $userInfo = EventModel::all(["uid"=>$uid]);
             $result["data"] = $userInfo;
             $result["code"] = 0;
             $result["msg"] = "获取成功";
         }else{
             $result['code'] = '1001';
             $result['msg'] = '尚未登录';
         }
         return json_encode($result);
     }


     //指定用户参加的Event
     public function join()
     {
         $result = array('code' => '-1','msg'=>'未知错误');   
         if(session("?uid")){
             $uid =  1;
             if( input("uid")){
                 $uid =   input("uid");
             }else{
                 $uid =   session("uid");
             }
             $eventList = StateModel::where([
                "uid"=>["=",$uid],
                "join"=>["=",1]
            ])->column('eid');
            $jionList = EventModel::all($eventList);
             $result["data"] = $jionList;
             $result["code"] = 0;
             $result["msg"] = "获取成功";
         }else{
             $result['code'] = '1001';
             $result['msg'] = '尚未登录';
         }
         return json_encode($result);
     }

    
   








    // 用户注销
    public function logout()
    {
        $result = array('code' => '0','msg'=>'退出成功','rows' => array());   
        session(null);
        return json_encode($result);
    }


}