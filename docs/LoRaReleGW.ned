//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Lesser General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
// 
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Lesser General Public License for more details.
// 
// You should have received a copy of the GNU Lesser General Public License
// along with this program.  If not, see http://www.gnu.org/licenses/.
// 

package flora.LoraNode;

import inet.mobility.static.StationaryMobility;
import inet.networklayer.common.InterfaceTable;
import inet.applications.contract.IApp;
import flora.LoRa.LoRaGWNic;
import flora.LoRa.PacketForwarder;
import inet.node.contract.INetworkNode;

module LoRaReleGW like INetworkNode
{
    parameters:
        int numApps = default(0);
        string deploymentType = default("");
        double maxGatewayDistance = default(320.0);
        double gatewayX = default(320.0);
        double gatewayY = default(320.0);
        
//      3 new lines
        int numWlanInterfaces = 1;
        LoRaGWNic.radio.antenna.mobilityModule = default("^.^.^.mobility");
        *.mobilityModule = default(exists(mobility) ? absPath(".mobility") : "");
        
        @networkNode();
        *.interfaceTableModule = default(absPath(".interfaceTable"));
        @display("bgb=783.96,587.688;i=device/antennatower");

    gates:
        inout radioIn[numWlanInterfaces] @directIn;

    submodules:
        interfaceTable: InterfaceTable {
            @display("p=30,26");
        }
        mobility: StationaryMobility {
            @display("p=24,88");
        }
        LoRaReleGWNic: LoRaGWNic {
            @display("p=350,80");
        }

    connections allowunconnected:

        LoRaReleGWNic.upperLayerOut --> LoRaReleGWNic.upperLayerIn;
        
         
//        packetForwarder.socketOut --> LoRaGWNic.upperLayerIn;
//        packetForwarder.socketIn <-- LoRaGWNic.upperLayerOut;
}
