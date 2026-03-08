import QtQuick 2.0
import calamares.slideshow 1.0

Presentation {
    id: presentation

    function nextSlide() {
        console.log("QML Component (default slideshow) Next slide");
        presentation.currentSlide = (presentation.currentSlide + 1) % presentation.slides.length;
    }

    Timer {
        id: advanceTimer
        interval: 5000
        running: presentation.activatedInCalamares
        repeat: true
        onTriggered: nextSlide()
    }

    Slide {
        Rectangle {
            anchors.fill: parent
            color: "#0A0A0F"
            
            Column {
                anchors.centerIn: parent
                spacing: 20
                
                Text {
                    text: "Welcome to Phantom OS"
                    font.pixelSize: 36
                    font.bold: true
                    color: "#00F0FF"
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                
                Text {
                    text: "A highly customizable Arch-based distribution"
                    font.pixelSize: 18
                    color: "#E0E0E8"
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                
                Text {
                    text: "with a neon-dark aesthetic built on Hyprland"
                    font.pixelSize: 18
                    color: "#E0E0E8"
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }
        }
    }

    Slide {
        Rectangle {
            anchors.fill: parent
            color: "#0A0A0F"
            
            Column {
                anchors.centerIn: parent
                spacing: 20
                
                Text {
                    text: "Ghost Protocol Theme"
                    font.pixelSize: 32
                    font.bold: true
                    color: "#00F0FF"
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                
                Text {
                    text: "• Neon cyan accents on deep black"
                    font.pixelSize: 16
                    color: "#E0E0E8"
                }
                
                Text {
                    text: "• Three-capsule floating panel layout"
                    font.pixelSize: 16
                    color: "#E0E0E8"
                }
                
                Text {
                    text: "• Floating glass dock with blur effects"
                    font.pixelSize: 16
                    color: "#E0E0E8"
                }
                
                Text {
                    text: "• 5 preset themes + custom theme editor"
                    font.pixelSize: 16
                    color: "#E0E0E8"
                }
            }
        }
    }

    Slide {
        Rectangle {
            anchors.fill: parent
            color: "#0A0A0F"
            
            Column {
                anchors.centerIn: parent
                spacing: 20
                
                Text {
                    text: "Performance Optimized"
                    font.pixelSize: 32
                    font.bold: true
                    color: "#00F0FF"
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                
                Text {
                    text: "• zram compressed swap"
                    font.pixelSize: 16
                    color: "#E0E0E8"
                }
                
                Text {
                    text: "• Optimized I/O schedulers"
                    font.pixelSize: 16
                    color: "#E0E0E8"
                }
                
                Text {
                    text: "• GPU auto-detection (NVIDIA/AMD/Intel)"
                    font.pixelSize: 16
                    color: "#E0E0E8"
                }
                
                Text {
                    text: "• Power profiles (Performance/Balanced/Powersave)"
                    font.pixelSize: 16
                    color: "#E0E0E8"
                }
                
                Text {
                    text: "• 3-5 second boot time target"
                    font.pixelSize: 16
                    color: "#E0E0E8"
                }
            }
        }
    }

    Slide {
        Rectangle {
            anchors.fill: parent
            color: "#0A0A0F"
            
            Column {
                anchors.centerIn: parent
                spacing: 20
                
                Text {
                    text: "Optional Pentesting Toolkit"
                    font.pixelSize: 32
                    font.bold: true
                    color: "#00F0FF"
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                
                Text {
                    text: "Install 50+ security tools with one command:"
                    font.pixelSize: 16
                    color: "#E0E0E8"
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                
                Text {
                    text: "sudo phantom-pentest install"
                    font.pixelSize: 18
                    font.family: "monospace"
                    color: "#7B68EE"
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                
                Text {
                    text: "Includes: nmap, wireshark, burpsuite, metasploit,"
                    font.pixelSize: 14
                    color: "#6B6B80"
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                
                Text {
                    text: "john, hashcat, aircrack-ng, and more"
                    font.pixelSize: 14
                    color: "#6B6B80"
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }
        }
    }

    Slide {
        Rectangle {
            anchors.fill: parent
            color: "#0A0A0F"
            
            Column {
                anchors.centerIn: parent
                spacing: 20
                
                Text {
                    text: "Installation Complete!"
                    font.pixelSize: 36
                    font.bold: true
                    color: "#00F0FF"
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                
                Text {
                    text: "Quick Start Commands:"
                    font.pixelSize: 20
                    color: "#E0E0E8"
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                
                Text {
                    text: "phantom-theme list          # View available themes"
                    font.pixelSize: 14
                    font.family: "monospace"
                    color: "#6B6B80"
                }
                
                Text {
                    text: "phantom-power set balanced  # Set power profile"
                    font.pixelSize: 14
                    font.family: "monospace"
                    color: "#6B6B80"
                }
                
                Text {
                    text: "phantom-pentest install     # Install pentesting tools"
                    font.pixelSize: 14
                    font.family: "monospace"
                    color: "#6B6B80"
                }
                
                Text {
                    text: "Enjoy Phantom OS!"
                    font.pixelSize: 18
                    color: "#E0E0E8"
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }
        }
    }
}
