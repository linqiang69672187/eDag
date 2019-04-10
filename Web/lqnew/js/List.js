var List = function () {
    {
        this.data = new Array();
    }
    this.data;
    this.add = function (jsondata) {
        var iflag = false;
        for (var i = 0; i < this.data.length; i++) {
            if (jsondata.id == this.data[i].id) {
                iflag = true;
            }
        }
        if (!iflag) {
            this.data.push(jsondata);
        }
    };
    this.remove = function (id) {
        var tempArray = new Array();
        for (var i = 0; i < this.data.length; i++) {
            if (this.data[i].id != id) {
                tempArray.push(this.data[i]);
            }
        }
        this.data.length = 0;
        for (var i = 0; i < tempArray.length; i++) {
            this.data.push(tempArray[i]);
        }
    }

}