<?php
namespace app\index\model;

use think\Model;

class Event extends Model
{
    protected $autoWriteTimestamp = true;
    protected $createTime = 'create_at';
    protected $updateTime = 'update_at';

    protected $auto = ['start','description','avatar'];
    
    protected function setStartAttr($value)
    {
        return time();
    }

    protected function setDescriptionAttr($value)
    {
        return $value?$value:"No Description";
    }

     protected function setAvatarAttr($value)
    {
        return $value?$value:"/static/img/user.jpg";
    }



}