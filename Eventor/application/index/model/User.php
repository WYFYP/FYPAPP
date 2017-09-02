<?php
namespace app\index\model;

use think\Model;

class User extends Model
{
     protected $autoWriteTimestamp = true;
    protected $createTime = 'create_at';
    protected $updateTime = 'update_at';

    
    protected $auto = ['password'];
    
    protected function setPasswordAttr($value)
    {
        return md5($value);
    }

}