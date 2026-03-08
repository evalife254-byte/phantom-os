// Phantom OS SDDM Theme — Ghost Protocol
// Split layout: left branding + clock, right login form

import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import SddmComponents 2.0

Rectangle {
    id: root

    width: Screen.width
    height: Screen.height
    color: config.BackgroundColor || "#0A0A0F"

    property color accentPrimary: config.AccentPrimary || "#00F0FF"
    property color accentSecondary: config.AccentSecondary || "#7B68EE"
    property color surfaceColor: config.SurfaceColor || "#141420"
    property color panelColor: config.PanelColor || "#1A1A2E"
    property color textPrimary: config.TextPrimary || "#E0E0E8"
    property color textSecondary: config.TextSecondary || "#6B6B80"
    property string fontFamily: config.Font || "Noto Sans"
    property int baseFontSize: config.FontSize ? parseInt(config.FontSize) : 12

    // ── Left panel: branding + clock ────────────────────────
    Rectangle {
        id: leftPanel
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        width: parent.width * 0.45
        color: root.surfaceColor

        // Subtle accent glow line on the right edge
        Rectangle {
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            width: 2
            color: root.accentPrimary
            opacity: 0.4
        }

        Column {
            anchors.centerIn: parent
            spacing: 24

            // OS branding title
            Text {
                text: config.HeaderText || "PHANTOM OS"
                font.family: root.fontFamily
                font.pixelSize: root.baseFontSize * 3
                font.weight: Font.Bold
                font.letterSpacing: 8
                color: root.accentPrimary
                anchors.horizontalCenter: parent.horizontalCenter
            }

            // Subtle tagline
            Text {
                text: "Ghost Protocol"
                font.family: root.fontFamily
                font.pixelSize: root.baseFontSize * 1.2
                font.letterSpacing: 4
                color: root.textSecondary
                anchors.horizontalCenter: parent.horizontalCenter
            }

            // Spacer
            Item { width: 1; height: 40 }

            // Clock
            Text {
                id: clockText
                font.family: root.fontFamily
                font.pixelSize: root.baseFontSize * 5
                font.weight: Font.Light
                color: root.textPrimary
                anchors.horizontalCenter: parent.horizontalCenter

                function updateTime() {
                    var now = new Date()
                    var hours = now.getHours().toString().padStart(2, '0')
                    var minutes = now.getMinutes().toString().padStart(2, '0')
                    text = hours + ":" + minutes
                }

                Timer {
                    interval: 1000
                    running: true
                    repeat: true
                    triggeredOnStart: true
                    onTriggered: clockText.updateTime()
                }

                Component.onCompleted: updateTime()
            }

            // Date
            Text {
                id: dateText
                font.family: root.fontFamily
                font.pixelSize: root.baseFontSize * 1.4
                font.letterSpacing: 2
                color: root.textSecondary
                anchors.horizontalCenter: parent.horizontalCenter

                function updateDate() {
                    var now = new Date()
                    var days = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
                    var months = ["January", "February", "March", "April", "May", "June",
                                  "July", "August", "September", "October", "November", "December"]
                    text = days[now.getDay()] + ", " + months[now.getMonth()] + " " + now.getDate()
                }

                Timer {
                    interval: 60000
                    running: true
                    repeat: true
                    triggeredOnStart: true
                    onTriggered: dateText.updateDate()
                }

                Component.onCompleted: updateDate()
            }

            // Spacer
            Item { width: 1; height: 60 }

            // Hostname
            Text {
                text: sddm.hostName
                font.family: root.fontFamily
                font.pixelSize: root.baseFontSize
                font.letterSpacing: 2
                color: root.textSecondary
                opacity: 0.6
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }
    }

    // ── Right panel: login form ─────────────────────────────
    Rectangle {
        id: rightPanel
        anchors.left: leftPanel.right
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        color: root.color

        Column {
            id: loginForm
            anchors.centerIn: parent
            width: parent.width * 0.6
            spacing: 16

            // User avatar or icon placeholder
            Rectangle {
                width: 80
                height: 80
                radius: 40
                color: root.panelColor
                border.color: root.accentPrimary
                border.width: 2
                anchors.horizontalCenter: parent.horizontalCenter

                Text {
                    anchors.centerIn: parent
                    text: "\uD83D\uDC64"
                    font.pixelSize: 32
                }
            }

            Item { width: 1; height: 8 }

            // Username field
            TextField {
                id: usernameField
                width: parent.width
                height: 48
                placeholderText: "Username"
                text: userModel.lastUser
                font.family: root.fontFamily
                font.pixelSize: root.baseFontSize * 1.1
                color: root.textPrimary
                placeholderTextColor: root.textSecondary

                background: Rectangle {
                    color: root.panelColor
                    radius: 12
                    border.color: usernameField.activeFocus ? root.accentPrimary : "transparent"
                    border.width: 2
                }

                leftPadding: 16
                rightPadding: 16

                Keys.onReturnPressed: passwordField.forceActiveFocus()
                Keys.onTabPressed: passwordField.forceActiveFocus()
            }

            // Password field
            TextField {
                id: passwordField
                width: parent.width
                height: 48
                placeholderText: "Password"
                echoMode: TextInput.Password
                font.family: root.fontFamily
                font.pixelSize: root.baseFontSize * 1.1
                color: root.textPrimary
                placeholderTextColor: root.textSecondary

                background: Rectangle {
                    color: root.panelColor
                    radius: 12
                    border.color: passwordField.activeFocus ? root.accentPrimary : "transparent"
                    border.width: 2
                }

                leftPadding: 16
                rightPadding: 16

                Keys.onReturnPressed: sddm.login(usernameField.text, passwordField.text, sessionSelect.currentIndex)
            }

            // Session selector
            ComboBox {
                id: sessionSelect
                width: parent.width
                height: 40
                model: sessionModel
                currentIndex: sessionModel.lastIndex
                textRole: "name"
                font.family: root.fontFamily
                font.pixelSize: root.baseFontSize

                background: Rectangle {
                    color: root.panelColor
                    radius: 10
                    border.color: sessionSelect.pressed ? root.accentPrimary : "transparent"
                    border.width: 1
                }

                contentItem: Text {
                    text: sessionSelect.displayText
                    font: sessionSelect.font
                    color: root.textSecondary
                    verticalAlignment: Text.AlignVCenter
                    leftPadding: 16
                }

                popup: Popup {
                    y: sessionSelect.height
                    width: sessionSelect.width
                    padding: 4

                    background: Rectangle {
                        color: root.panelColor
                        radius: 10
                        border.color: root.accentPrimary
                        border.width: 1
                    }

                    contentItem: ListView {
                        clip: true
                        implicitHeight: contentHeight
                        model: sessionSelect.popup.visible ? sessionSelect.delegateModel : null
                        ScrollIndicator.vertical: ScrollIndicator {}
                    }
                }

                delegate: ItemDelegate {
                    width: sessionSelect.width
                    height: 36

                    contentItem: Text {
                        text: model.name
                        font.family: root.fontFamily
                        font.pixelSize: root.baseFontSize
                        color: highlighted ? root.accentPrimary : root.textPrimary
                        verticalAlignment: Text.AlignVCenter
                        leftPadding: 12
                    }

                    background: Rectangle {
                        color: highlighted ? Qt.rgba(0, 0.94, 1, 0.1) : "transparent"
                        radius: 8
                    }

                    highlighted: sessionSelect.highlightedIndex === index
                }
            }

            Item { width: 1; height: 8 }

            // Login button
            Button {
                id: loginButton
                width: parent.width
                height: 48
                text: "Login"
                font.family: root.fontFamily
                font.pixelSize: root.baseFontSize * 1.2
                font.weight: Font.Bold

                contentItem: Text {
                    text: loginButton.text
                    font: loginButton.font
                    color: root.color
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }

                background: Rectangle {
                    color: loginButton.pressed ? root.accentSecondary : root.accentPrimary
                    radius: 12
                }

                onClicked: sddm.login(usernameField.text, passwordField.text, sessionSelect.currentIndex)
            }

            // Error message
            Text {
                id: errorMessage
                width: parent.width
                text: ""
                font.family: root.fontFamily
                font.pixelSize: root.baseFontSize
                color: "#FF6B6B"
                horizontalAlignment: Text.AlignHCenter
                visible: text !== ""
            }
        }

        // Power buttons row at bottom-right
        Row {
            anchors.bottom: parent.bottom
            anchors.right: parent.right
            anchors.margins: 24
            spacing: 16

            // Suspend
            Button {
                id: suspendBtn
                width: 36
                height: 36
                visible: sddm.canSuspend
                font.family: root.fontFamily
                font.pixelSize: 14

                contentItem: Text {
                    text: "\u23FB"
                    font.pixelSize: 16
                    color: root.textSecondary
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }

                background: Rectangle {
                    color: suspendBtn.hovered ? root.panelColor : "transparent"
                    radius: 8
                }

                ToolTip.visible: hovered
                ToolTip.text: "Suspend"

                onClicked: sddm.suspend()
            }

            // Reboot
            Button {
                id: rebootBtn
                width: 36
                height: 36
                visible: sddm.canReboot
                font.family: root.fontFamily
                font.pixelSize: 14

                contentItem: Text {
                    text: "\u21BB"
                    font.pixelSize: 18
                    color: root.textSecondary
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }

                background: Rectangle {
                    color: rebootBtn.hovered ? root.panelColor : "transparent"
                    radius: 8
                }

                ToolTip.visible: hovered
                ToolTip.text: "Reboot"

                onClicked: sddm.reboot()
            }

            // Power off
            Button {
                id: powerOffBtn
                width: 36
                height: 36
                visible: sddm.canPowerOff
                font.family: root.fontFamily
                font.pixelSize: 14

                contentItem: Text {
                    text: "\u23FC"
                    font.pixelSize: 16
                    color: root.textSecondary
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }

                background: Rectangle {
                    color: powerOffBtn.hovered ? root.panelColor : "transparent"
                    radius: 8
                }

                ToolTip.visible: hovered
                ToolTip.text: "Power Off"

                onClicked: sddm.powerOff()
            }
        }
    }

    // ── Login result handling ────────────────────────────────
    Connections {
        target: sddm
        function onLoginFailed() {
            passwordField.text = ""
            errorMessage.text = "Login failed. Please try again."
            passwordField.forceActiveFocus()
        }
        function onLoginSucceeded() {
            errorMessage.text = ""
        }
    }

    // Focus password field on load if username is pre-filled
    Component.onCompleted: {
        if (usernameField.text !== "") {
            passwordField.forceActiveFocus()
        } else {
            usernameField.forceActiveFocus()
        }
    }
}
