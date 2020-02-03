import QtQuick 2.6
import QtQuick.Window 2.12
import QtPositioning 5.11
import QtQuick.Controls 2.12
import Qt.labs.folderlistmodel 1.0
import QtQuick.Dialogs 1.1
Window {

    id: window
    visible: true
    title: qsTr("ERMAKSAN")
    width:  Qt.platform.os == "android" ?600:800
    height: Qt.platform.os == "android" ?900:600

    Image {
        id: img_logo
        width: (window.width+window.height)/30+7
        height: width
        enabled: true
        anchors.left: parent.left
        anchors.leftMargin: 50
        anchors.top: parent.top
        anchors.topMargin: 30
        layer.mipmap: true
        fillMode: Image.PreserveAspectFit
        source: "qrc:/images/logo.png"
        MouseArea{
            id: mouseArea1
            anchors.fill: parent
            onClicked: fileDialogLogo.open()
        }
    }

    TextEdit {
        id: txt_sirketadi
        text: qsTr("ERMAKSAN")
        horizontalAlignment: Text.AlignLeft
        anchors.left: img_logo.right
        anchors.leftMargin: 10
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 30
        clip: true
        font.pixelSize: (window.width+window.height)/30

        onTextChanged: {
            if(this.length>20){
                undo()
            }

        }

    }
    Image {
        id: img_resim
        height: window.height*0.25
        width: window.width*0.3
        enabled: true
        anchors.top: txt_baslik.top
        anchors.topMargin: 0
        anchors.right: view.left
        anchors.rightMargin: 25
        layer.mipmap: true
        fillMode: Image.PreserveAspectFit
        source: "qrc:/images/ermaksan.png"
        MouseArea{
            id: mouseArea2
            anchors.fill: parent
            onClicked: fileDialogResim.open()
        }
    }

    ScrollView{
        id: view
        width: window.width*0.6
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.top: txt_baslik.bottom
        anchors.topMargin: 30
        anchors.right: parent.right
        anchors.rightMargin: 0
        focusPolicy: Qt.StrongFocus
        ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
        clip: true
        TextArea {
            id: txt_yazi
            x: -10
            y: 0
            width: parent.width-10
            height: parent.height
            text: { var i=0
                while(i<15){
                    this.text+="Lorem ipsum dolor sit amet, consectetur adipiscing elit."
                    i++
                }
            }
            anchors.rightMargin: -10
            anchors.bottomMargin: 0
            clip: false
            selectByMouse: true
            wrapMode: Text.WrapAnywhere
            font.pixelSize: (window.width+window.height)/60
        }
    }

    TextEdit {
        id: txt_baslik
        width: window.width*0.6
        height: 24
        text: "Başlık Metni"
        anchors.top: txt_sirketadi.bottom
        anchors.topMargin: 20
        anchors.right: parent.right
        anchors.rightMargin: 0
        horizontalAlignment: Text.AlignLeft
        font.pixelSize: (window.width+window.height)/60
        onTextChanged: {
            if(this.length>25){
                undo()
            }
        }
    }

    Button {
        id: button
        x: 50
        y: window.height*0.9
        width: 75
        height: 25
        text: qsTr("Yazdır")
        onClicked: {
            console.log(img_logo.source)
            var pdf = _pdfyazdir.yazdir(txt_sirketadi.text,txt_baslik.text,txt_yazi.text,
                                        getSource(img_logo.source),getSource(img_resim.source),Qt.platform.os);
            messageDialog.text +="\n"+ pdf+" Adresine kaydedildi! \n Çıkış için basın." ;
            messageDialog.open();
        }

    }

    MessageDialog {
        id: messageDialog
        icon: StandardIcon.Information
        title: "Pdf Yazıldı"
        text: "Pdf yazdırma işlemi  tamamlandı."
        onAccepted: {
            Qt.quit()
        }
    }




    FileDialog {
        id: fileDialogLogo
        folder: shortcuts.home
        nameFilters: [ "Image files (*.jpg *.png)" ]
        onAccepted: img_logo.source=setSource(this.fileUrl)
    }
    FileDialog {
        id: fileDialogResim
        folder: shortcuts.home
        nameFilters: [ "Image files (*.jpg *.png)" ]
        onAccepted: img_resim.source=setSource(this.fileUrl)
    }



    function islocal(path){
        return (""+ path).slice(0,8)=== "file:///";
    }
    function isresources(path){
        return (""+ path).slice(0,3)=== "qrc";
    }

    function setSource(path){

        if((""+path).slice(0,1)=== "/")
            return "file://" + path
        else if(islocal(path))
            return "file:/"+(""+path).substr(8)

        else
            return path
    }
    function getSource(path){
        if (islocal(path))
            return (""+path).substr(8)
        else if(isresources(path))
            return (""+path).substring(3)
        else
            return path
    }
}




/*##^##
Designer {
    D{i:2;anchors_height:48;anchors_width:426.6666666666667;anchors_y:30}D{i:1;anchors_width:56.06666666666667;anchors_x:44;anchors_y:30}
D{i:3;anchors_width:85;anchors_x:50;anchors_y:277}D{i:5;anchors_height:260;anchors_width:380;anchors_x:0;anchors_y:0}
D{i:4;anchors_height:288}D{i:6;anchors_height:24;anchors_width:380;anchors_x:0;anchors_y:117}
}
##^##*/
