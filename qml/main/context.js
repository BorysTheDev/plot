.pragma library

//scale - number px in unit
function CartesianContext(ctx, scale, startX, startY) {
    this.ctx = ctx;
    this.scale = scale;

    // private variable
    this.startX = ctx.canvas.width / 2 + scale * startX;
    this.startY = ctx.canvas.height / 2 - scale * startY;

    // public variable
    this.leftX  = -this.startX / scale;
    this.downY  = (this.startY - ctx.canvas.height) / scale;
    this.rightX = (ctx.canvas.width - this.startX) / scale;
    this.upY    = this.startY / scale;

    // context2d properties
    this.lineWidth = 1;
    // function from context2d
    this.moveTo = function(x, y) {
        this.ctx.moveTo(this.fromCortesianX(x), this.fromCortesianY(y));
    }

    this.lineTo = function(x, y) {
        this.ctx.lineTo(this.fromCortesianX(x), this.fromCortesianY(y));
    }

    this.reset = function() {
        this.ctx.reset();
    }

    this.stroke = function() {
        this.ctx.lineWidth = 1;
        this.ctx.stroke();
    }

    //private functions
    this.fromCortesianX = function(x) {
        return this.startX + x * scale;
    }

    this.fromCortesianY = function(y) {
        return this.startY - y * scale;
    }
}
