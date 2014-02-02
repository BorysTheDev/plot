.pragma library

function Plot(CartesianContext) {

    this.ctx = CartesianContext;

    this.axis = function(arrowLen){
        arrowLen = arrowLen || 12;
        var angle = Math.PI/6;  //angle of arrow

        var sinArrowShift = (arrowLen / this.ctx.scale) * Math.sin(angle);
        var cosArrowShift = (arrowLen / this.ctx.scale) * Math.cos(angle);
        this.ctx.moveTo(0, this.ctx.downY);
        this.ctx.lineTo(0, this.ctx.upY);
        this.ctx.moveTo(-sinArrowShift, this.ctx.upY - cosArrowShift);
        this.ctx.lineTo(0, this.ctx.upY);
        this.ctx.lineTo(sinArrowShift, this.ctx.upY - cosArrowShift);
        this.ctx.moveTo(this.ctx.leftX, 0);
        this.ctx.lineTo(this.ctx.rightX, 0);
        this.ctx.moveTo(this.ctx.rightX - cosArrowShift, -sinArrowShift);
        this.ctx.lineTo(this.ctx.rightX, 0);
        this.ctx.lineTo(this.ctx.rightX - cosArrowShift, sinArrowShift);

        this.ctx.stroke();
    };

    this.curve = function(curve){
        var i = -1.00001;
        this.ctx.moveTo(curve.x(i), curve.y(i));
        while((i += 0.01) <= 1.00001) {
            //console.log(i, x(i), y(i), "\n")
            this.ctx.lineTo(curve.x(i), curve.y(i));
        }
        this.ctx.stroke();
    }
}

