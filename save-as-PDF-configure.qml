import QtQuick 2.2
import QtQuick.Controls 1.1
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.1
import QtQuick.Window 2.2
import Qt.labs.folderlistmodel 2.1
import Qt.labs.settings 1.0

import MuseScore 3.0


MuseScore {
	menuPath: "Plugins.Save As PDF.Configure"
	description: "Choose folder location for the Save As PDF plugin"
	version: "1.0"
	pluginType: "dialog"
	requiresScore: false
	id: 'pluginId'

	width:  360
	height: 80

	onRun: {
		directorySelectDialog.folder = ((Qt.platform.os == "windows")? "file:///" : "file://") + exportDirectory.text;
	}

	Component.onDestruction: {
		settings.exportDirectory = exportDirectory.text
	}

	Settings {
		id: settings
		category: "Plugin-SaveAsPDF"
		property alias exportDirectory: exportDirectory.text
	}

	FileDialog {
		id: directorySelectDialog
		title: qsTranslate("MS::PathListDialog", "Choose a directory")
		selectFolder: true
		visible: false
		onAccepted: {
			exportDirectory.text = this.folder.toString().replace("file://", "").replace(/^\/(.:\/)(.*)$/, "$1$2");
		}
		Component.onCompleted: visible = false
	}

	GridLayout {
		columns: 2
		anchors.fill: parent
		anchors.margins: 10

		Button {
			id: selectDirectory
			text: qsTranslate("PrefsDialogBase", "Browse...")
			onClicked: {
				directorySelectDialog.open();
			}
		}
		Label {
			id: exportDirectory
			text: ""
		}

		Button {
			id: closeButton
			Layout.columnSpan: 2
			text: qsTranslate("action", "Close")
			onClicked: {
				pluginId.parent.Window.window.close();
			}
		}
	}
}
