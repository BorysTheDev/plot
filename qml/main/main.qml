import QtQuick 2.1
import QtQuick.Controls 1.0
import "context.js" as CartCntx
import "plot.js" as Plt
import "global_variables.js" as GlobalVar

ApplicationWindow {
    title: qsTr("Hello World")


    menuBar: MenuBar {
        Menu {
            title: qsTr("File")
            MenuItem {
                text: qsTr("Exit")
                onTriggered: Qt.quit();
            }
        }
    }


    width: 700
    height: 500


    Rectangle {
        id: graphRectangle
        radius: 5
        border.width: 1
        anchors.topMargin: 5

        anchors.bottomMargin: 5
        anchors.leftMargin: 5
        anchors.right: column1.left
        anchors.bottom: rowRectangle.top
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.rightMargin: 5
        Canvas{
            id : graphCanvas
            anchors.rightMargin: 5
            anchors.leftMargin: 5
            anchors.bottomMargin: 5
            anchors.topMargin: 5
            anchors.fill: parent
            function pow(a,b){return Math.pow(a,b);}
            function sqrt(a){return Math.sqrt(a);}
            function sin(a){return Math.sin(a);}
            function cos(a){return Math.cos(a);}
            function exp(a){return Math.exp(a);}
            onPaint: {
                var ctx1 = graphCanvas.getContext("2d");
                var ctx = new CartCntx.CartesianContext(ctx1, 20, -3, -3);
                ctx.reset();
                var plot = new Plt.Plot(ctx);
                plot.axis();
                for (var i = 0; i < GlobalVar.curves.length; i++) {
                    var x = "function(t){return " + GlobalVar.curves[i].x + ";}"
                    var y = "function(t){return " + GlobalVar.curves[i].y + ";}"
                    plot.curve({'x' : eval(x), 'y' : eval(y)});
                }
            }
        }


    }

    Rectangle {
        id: rowRectangle
        y: 345
        height: 150
        radius: 5
        border.width: 1
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 4
        anchors.right: column1.left
        anchors.rightMargin: 5
        anchors.left: parent.left
        anchors.leftMargin: 5

        TextField {
            id: xFromT
            x: 48
            y: 44
            placeholderText: ""
        }

        TextField {
            id: yFromT
            x: 48
            y: 70
            placeholderText: ""
        }

        TextField {
            id: dxFromT
            x: 48
            y: 96
            placeholderText: ""
        }

        TextField {
            id: dyFromT
            x: 48
            y: 122
            placeholderText: ""
        }

        Text {
            id: text1
            x: 8
            y: 50
            text: "x(t)="
            font.pixelSize: 12
        }

        Text {
            id: text2
            x: 8
            y: 76
            text: "y(t)="
            font.pixelSize: 12
        }

        Text {
            id: text3
            x: 8
            y: 102
            text: "dx/dt="
            font.pixelSize: 12
        }

        Text {
            id: text4
            x: 8
            y: 127
            text: "dy/dt="
            font.pixelSize: 12
        }

        Button {
            x: 452
            y: 118
            text: "Add"
            onClicked: {
                GlobalVar.curves.push({'x' : xFromT.text,'y' : yFromT.text,
                                          'name' : 'curve'+ GlobalVar.curves.length});
                graphCanvas.requestPaint();
            }
        }

        Text {
            id: text5
            x: 8
            y: 13
            text: "t is [-1, 1]"
            font.pixelSize: 12
        }


    }

    Rectangle {
        id: column1
        width: 150
        radius: 5
        border.width: 1
        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 5
        anchors.top: parent.top
        anchors.topMargin: 5

        ComboBox {
            id: curves
            x: 13
            y: 101
            model: ["line", "Parabola"]

            onCurrentTextChanged: {
                switch (currentIndex){
                case 0:
                    xFromT.text = "(1 - t) / 2 + (1 + t) / 2";
                    yFromT.text = "pow(1*(1-t)/2+1*(1+t)/2,2)/1";
                    //dxFromT.text = "(1 - t) / 2 + ( 1 + t) / 2";
                    //dyFromT.text = "(1 - t) / 2 + ( 1 + t) / 2";
                    break;
                case 1:
                    break;
                }

            }
        }

    }

}
