import QtQuick 2.1
import QtQuick.Controls 1.0
import Json 1.0
import "context.js" as CartCntx
import "plot.js" as Plt
import "global_variables.js" as GlobalVar

ApplicationWindow {
    title: qsTr("Plot Master")


    menuBar: MenuBar {
        Menu {
            title: qsTr("File")
            MenuItem {
                text: qsTr("Exit")
                onTriggered: Qt.quit();
            }
        }
    }

    Json {
        id: json
    }

    width: 1280
    height: 720


    Rectangle {
        id: graphRectangle
        width: 533
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
            width: 525
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
                for (var i = 0; i < GlobalVar.curvesLength; i++) {
                    var name = GlobalVar.curvesNames[i];
                    var x = "function(t){return " + GlobalVar.curves[name]['constructor']['x'] + ";}"
                    var y = "function(t){return " + GlobalVar.curves[name]['constructor']['y'] + ";}"
                    plot.curve({'x' : eval(x), 'y' : eval(y)});
                }
            }
        }


    }

    Rectangle {
        id: rowRectangle
        y: 345
        width: 535
        height: 165
        radius: 5
        border.width: 1
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 4
        anchors.right: column1.left
        anchors.rightMargin: 5
        anchors.left: parent.left
        anchors.leftMargin: 5

        TextField {
            id: nameStr
            x: 55
            y: 32
            placeholderText: ""
        }

        TextField {
            id: xFromT
            x: 55
            y: 57
            placeholderText: ""
        }

        TextField {
            id: yFromT
            x: 55
            y: 82
            placeholderText: ""
        }

        TextField {
            id: dxFromT
            x: 55
            y: 107
            placeholderText: ""
        }

        TextField {
            id: dyFromT
            x: 55
            y: 132
            placeholderText: ""
        }

        Text {
            id: text5
            x: 10
            y: 10
            text: "t is [-1, 1]"
            font.pixelSize: 12
        }

        Text {
            id: name
            x: 10
            y: 35
            text: "Name"
            font.pixelSize: 12
        }

        Text {
            id: text1
            x: 10
            y: 60
            text: "x(t)="
            font.pixelSize: 12
        }

        Text {
            id: text2
            x: 10
            y: 85
            text: "y(t)="
            font.pixelSize: 12
        }

        Text {
            id: text3
            x: 10
            y: 110
            text: "dx/dt="
            font.pixelSize: 12
        }

        Text {
            id: text4
            x: 10
            y: 135
            text: "dy/dt="
            font.pixelSize: 12
        }

        Button {
            x: 452
            y: 118
            text: "Add"
            onClicked: {
                var flag = true;
                for(var i=0; i<GlobalVar.curvesNames.length; i++)
                    if(nameStr.text === GlobalVar.curvesNames[i])
                        flag = false;
                if(flag)
                {
                    var curName;
                    if(nameStr.text === "")
                        curName = "curve" + GlobalVar.curvesLength;
                    else
                        curName = nameStr.text;
                    GlobalVar.curvesNames.push(curName);
                    var temp = {};
                    temp['x'] = xFromT.text;
                    temp['dx'] = dxFromT.text;
                    temp['y'] = yFromT.text;
                    temp['dy'] = dyFromT.text;
                    GlobalVar.curves[curName] = {};
                    GlobalVar.curves[curName]['type'] = 'userType';
                    GlobalVar.curves[curName]['constructor'] = temp;
                    GlobalVar.curves[curName]['numberOfPoints'] = 40;
                    GlobalVar.curvesLength++;
                    listModel.append({'name' : curName});
                    curveList.currentIndex = GlobalVar.curvesLength - 1;
                    graphCanvas.requestPaint();
                }
            }
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
                    //xFromT.text = "(1 - t) / 2 + (1 + t) / 2";
                    //yFromT.text = "pow(1*(1-t)/2+1*(1+t)/2,2)/1";
                    //dxFromT.text = "(1 - t) / 2 + ( 1 + t) / 2";
                    //dyFromT.text = "(1 - t) / 2 + ( 1 + t) / 2";
                    break;
                case 1:
                    break;
                }

            }
        }

        ComboBox {
            id: curveList
            editable: true
            x: 13
            anchors.top: parent.top
            anchors.topMargin: 7
            anchors.right: parent.right
            anchors.rightMargin: 12
            model: ListModel {
                id: listModel
            }
            onCurrentIndexChanged: {
                if(count !== 0)
                {
                    var name = GlobalVar.curvesNames[currentIndex];
                    nameStr.text = name;
                    xFromT.text = GlobalVar.curves[name]['constructor']['x'];
                    yFromT.text = GlobalVar.curves[name]['constructor']['y'];
                    dxFromT.text = GlobalVar.curves[name]['constructor']['dx'];
                    dyFromT.text = GlobalVar.curves[name]['constructor']['dy'];
                }
            }
        }

        Button {
            id: calculate
            x: 13
            width: 125
            height: 23
            text: "Calculate"
            anchors.right: parent.right
            anchors.rightMargin: 12
            anchors.top: parent.top
            anchors.topMargin: 32
            onClicked: {
                GlobalVar.tasks['task1']['Curves'] = GlobalVar.curves;
                GlobalVar.tasks['task1']['Fields'] = GlobalVar.fields;
                json.setData(JSON.stringify(GlobalVar.tasks));
                json.toFile();
            }
        }

    }

}
