; 回调函数，间隔，持续时间，参数
HoldKey(callback, endCallback, period, leftTime, key)
{
    action := GetKeyAction(callback, endCallback, key)
    holdTimer := Timer(action, period)
    funcObj := ReleaseKey.Bind(holdTimer, endCallback, key)
    SetTimer funcObj, -leftTime, -1
}

GetKeyAction(callback, endCallback, key)
{
    ;//闭包
    action()
    {
        global ScriptInfo
        callback(key)
        funcObj := endCallback.Bind(key)
        SetTimer funcObj, -ScriptInfo.KeyAutoLooseTime
    }
    return action
}



ReleaseKey(holdTimer, callback, key)
{
    holdTimer := ""
    callback(key)
}

class Timer
{
    __New(callback, period)
    {
        this.binding := callback
        this.period := period
        this.priority := 0
        this.On()
    }

    __Delete()
    {
        this.Off()
    }

    On()
    {
        funcObj := this.binding
        SetTimer funcObj, this.period, this.priority
    }

    Off()
    {
        funcObj := this.binding
        SetTimer funcObj, 0
    }
}