//多个测距类
//BUG--缩放后被关闭的测距线会消失，因为被关闭了，缩放后的添加测距线也没了；想要改这个bug也没这么容易，因为如给缩放后添加事件时是根据函数体区分的，而每个测距对象的输出函数体肯定一样，不过可以在这个函数体内做相应改变，加上在Multi的队列位置即可解决（已修改）
function Multi_Ranging(map) {
    this.data = {
        id: "Multi_Ranging",
        map: map,
        rangings: new Array()//测距队列
    }
    //在添加新测距时在上个测距末尾增加关闭按钮
    this.addCloseBtnToLastRanging = function (ranging, multi_Ranging) {
    }
    this.isCloseBtnClickTurnOff = function (ranging, ev) {
        if (ev.srcElement.isClose) {
            ranging.set_iTurnOn(false, ranging);
        }
    }
    this.isCloseBtnClickTurnOn = function (ranging, ev) {
        if (ev.srcElement.isClose) {
            ranging.set_iTurnOn(true, ranging);
        }
    }
    this.addRanging = function () {
        //不存在测距对象在队列中 或 存在测距对象但已有节点(即被关闭测距了) 防止出现多次添加测距对象而不测距的情况
        //if (this.data.rangings.length == 0 || this.data.rangings[this.data.rangings.length - 1].iExistPoint_node(0)) {
        if (document.Ranging) {
            return;
        }
        var inMulti_Ranging_index = this.data.rangings.length;
        var ranging = new Ranging(this.data.map, inMulti_Ranging_index);
        ranging.inMulti_Ranging_index = inMulti_Ranging_index; //在Multi中的队列位置
        this.data.rangings.push(ranging);
        ranging.turnOn();
        //            ranging.addEventListener("turnOff", this.addCloseBtnToLastRanging, ranging, this);
        //            ranging.addEventListener("addNode_before", this.isCloseBtnClickTurnOff, ranging); //是关闭按钮单击事件 关闭添加节点 防止点击关闭按钮时，触发添加添加节点事件
        //            ranging.addEventListener("addNode_after", this.isCloseBtnClickTurnOn, ranging); //是关闭按钮单击事件 开启添加节点
        //            ranging.addEventListener("finish", this.closeAll, this); //双击一个测距关闭就关闭全部
        //}
    }

    this.closeAll = function () {
        with (this) {
            for (var ranging_i = 0; ranging_i < data.rangings.length; ranging_i++) {
                document.Ranging = data.rangings[ranging_i];
                document.Ranging.removeAllToMap.call(document.Ranging);
                document.Ranging.removeAllData.call(document.Ranging);
                document.Ranging.turnOff.call(document.Ranging);
                document.Ranging = null;
            }
            data.rangings = new Array();
        }
    }
    {
        _StaticObj.add(this, this.data.id);
    }

    this.stopAll = function () { //关闭未关闭的测距
        with (this) {
            for (var ranging_i = 0; ranging_i < data.rangings.length; ranging_i++) {
                document.Ranging = data.rangings[ranging_i];
                document.Ranging.turnOff.call(document.Ranging);
                document.Ranging = null;
            }
        }
    }
    

}