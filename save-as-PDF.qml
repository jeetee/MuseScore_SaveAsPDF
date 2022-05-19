import QtQuick 2.2
import Qt.labs.settings 1.0

import MuseScore 3.0


MuseScore {
	menuPath: "Plugins.Save As PDF.Export"
	description: "Save the current score as PDF in the configured folder."
	version: "1.0"
//	pluginType: undefined
	requiresScore: true

	Settings {
		id: settings
		category: "Plugin-SaveAsPDF"
		property string exportDirectory
	}

	onRun: {
		var newFileName = curScore.scoreName;
		newFileName = newFileName.replace(/ /g, "_");
		newFileName = settings.exportDirectory + "//" + newFileName;
		writeScore(curScore, newFileName, 'pdf');
	}
}
