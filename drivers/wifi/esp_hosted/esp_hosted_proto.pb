/* Copyright (C) 2015-2023 Espressif Systems (Shanghai) PTE LTD */
/* SPDX-License-Identifier: Apache-2.0 */

/* This file is sourced from
   https://github.com/espressif/esp-hosted/blob/master/esp_hosted_fg/common/proto/esp_hosted_config.proto
*/

syntax = "proto3";

/* Enums similar to ESP IDF */
enum Ctrl_VendorIEType {
    Beacon = 0;
    Probe_req = 1;
    Probe_resp = 2;
    Assoc_req = 3;
    Assoc_resp = 4;
}

enum Ctrl_VendorIEID {
    ID_0 = 0;
    ID_1 = 1;
}

enum Ctrl_WifiMode {
    NONE = 0;
    STA = 1;
    AP = 2;
    APSTA = 3;
}

enum Ctrl_WifiBw {
    BW_Invalid = 0;
    HT20 = 1;
    HT40 = 2;
}

enum Ctrl_WifiPowerSave {
    PS_Invalid = 0;
    MIN_MODEM = 1;
    MAX_MODEM = 2;
}

enum Ctrl_WifiSecProt {
    Open = 0;
    WEP = 1;
    WPA_PSK = 2;
    WPA2_PSK = 3;
    WPA_WPA2_PSK = 4;
    WPA2_ENTERPRISE = 5;
    WPA3_PSK = 6;
    WPA2_WPA3_PSK = 7;
}

/* enums for Control path */
enum Ctrl_Status {
    Connected = 0;
    Not_Connected = 1;
    No_AP_Found = 2;
    Connection_Fail = 3;
    Invalid_Argument = 4;
    Out_Of_Range = 5;
}


enum CtrlMsgType {
    MsgType_Invalid = 0;
    Req = 1;
    Resp = 2;
    Event = 3;
    MsgType_Max = 4;
}

enum CtrlMsgId {
    MsgId_Invalid = 0;

    /** Request Msgs **/
    Req_Base = 100;

    Req_GetMacAddress = 101;
    Req_SetMacAddress = 102;
    Req_GetWifiMode = 103;
    Req_SetWifiMode = 104;

    Req_GetAPScanList = 105;
    Req_GetAPConfig = 106;
    Req_ConnectAP = 107;
    Req_DisconnectAP = 108;

    Req_GetSoftAPConfig = 109;
    Req_SetSoftAPVendorSpecificIE = 110;
    Req_StartSoftAP = 111;
    Req_GetSoftAPConnectedSTAList = 112;
    Req_StopSoftAP = 113;

    Req_SetPowerSaveMode = 114;
    Req_GetPowerSaveMode = 115;

    Req_OTABegin = 116;
    Req_OTAWrite = 117;
    Req_OTAEnd = 118;

    Req_SetWifiMaxTxPower = 119;
    Req_GetWifiCurrTxPower = 120;

    Req_ConfigHeartbeat = 121;
    /* Add new control path command response before Req_Max
     * and update Req_Max */
    Req_Max = 122;

    /** Response Msgs **/
    Resp_Base = 200;

    Resp_GetMacAddress = 201;
    Resp_SetMacAddress = 202;
    Resp_GetWifiMode = 203;
    Resp_SetWifiMode = 204;

    Resp_GetAPScanList = 205;
    Resp_GetAPConfig = 206;
    Resp_ConnectAP = 207;
    Resp_DisconnectAP = 208;

    Resp_GetSoftAPConfig = 209;
    Resp_SetSoftAPVendorSpecificIE = 210;
    Resp_StartSoftAP = 211;
    Resp_GetSoftAPConnectedSTAList = 212;
    Resp_StopSoftAP = 213;

    Resp_SetPowerSaveMode = 214;
    Resp_GetPowerSaveMode = 215;

    Resp_OTABegin = 216;
    Resp_OTAWrite = 217;
    Resp_OTAEnd = 218;

    Resp_SetWifiMaxTxPower = 219;
    Resp_GetWifiCurrTxPower = 220;

    Resp_ConfigHeartbeat = 221;
    /* Add new control path command response before Resp_Max
     * and update Resp_Max */
    Resp_Max = 222;

    /** Event Msgs **/
    Event_Base = 300;
    Event_ESPInit = 301;
    Event_Heartbeat = 302;
    Event_StationDisconnectFromAP = 303;
    Event_StationDisconnectFromESPSoftAP = 304;
    /* Add new control path command notification before Event_Max
     * and update Event_Max */
    Event_Max = 305;
}

/* internal supporting structures for CtrlMsg */
message ScanResult {
    bytes ssid = 1;
    uint32 chnl = 2;
    int32 rssi = 3;
    bytes bssid = 4;
    Ctrl_WifiSecProt sec_prot = 5;
}

message ConnectedSTAList {
    bytes mac = 1;
    int32 rssi = 2;
}


/* Control path structures */
/** Req/Resp structure **/
message CtrlMsg_Req_GetMacAddress {
    int32 mode = 1;
}

message CtrlMsg_Resp_GetMacAddress {
    bytes mac = 1;
    int32 resp = 2;
}

message CtrlMsg_Req_GetMode {
}

message CtrlMsg_Resp_GetMode {
    int32 mode = 1;
    int32 resp = 2;
}

message CtrlMsg_Req_SetMode {
    int32 mode = 1;
}

message CtrlMsg_Resp_SetMode {
    int32 resp = 1;
}

message CtrlMsg_Req_GetStatus {
}

message CtrlMsg_Resp_GetStatus {
    int32 resp = 1;
}

message CtrlMsg_Req_SetMacAddress {
    bytes mac = 1;
    int32 mode = 2;
}

message CtrlMsg_Resp_SetMacAddress {
    int32 resp = 1;
}

message CtrlMsg_Req_GetAPConfig {
}

message CtrlMsg_Resp_GetAPConfig {
    bytes ssid = 1;
    bytes bssid = 2;
    int32 rssi = 3;
    int32 chnl = 4;
    Ctrl_WifiSecProt sec_prot = 5;
    int32 resp = 6;
}

message CtrlMsg_Req_ConnectAP {
    string ssid = 1;
    string pwd = 2;
    bytes bssid = 3;
    bool is_wpa3_supported = 4;
    int32 listen_interval = 5;
}

message  CtrlMsg_Resp_ConnectAP {
    int32 resp = 1;
    bytes mac = 2;
}

message CtrlMsg_Req_GetSoftAPConfig {
}

message CtrlMsg_Resp_GetSoftAPConfig {
    bytes ssid = 1;
    bytes pwd = 2;
    int32 chnl = 3;
    Ctrl_WifiSecProt sec_prot = 4;
    int32 max_conn = 5;
    bool ssid_hidden = 6;
    int32 bw = 7;
    int32 resp = 8;
}

message CtrlMsg_Req_StartSoftAP {
    string ssid = 1;
    string pwd = 2;
    int32 chnl = 3;
    Ctrl_WifiSecProt sec_prot = 4;
    int32 max_conn = 5;
    bool ssid_hidden = 6;
    int32 bw = 7;
}

message CtrlMsg_Resp_StartSoftAP {
    int32 resp = 1;
    bytes mac = 2;
}

message CtrlMsg_Req_ScanResult {
}

message CtrlMsg_Resp_ScanResult {
    uint32 count = 1;
    repeated ScanResult entries = 2;
    int32 resp = 3;
}

message CtrlMsg_Req_SoftAPConnectedSTA {
}

message CtrlMsg_Resp_SoftAPConnectedSTA {
    uint32 num = 1;
    repeated ConnectedSTAList stations = 2;
    int32 resp = 3;
}

message CtrlMsg_Req_OTABegin {
}

message CtrlMsg_Resp_OTABegin {
    int32 resp = 1;
}

message CtrlMsg_Req_OTAWrite {
    bytes ota_data = 1;
}

message CtrlMsg_Resp_OTAWrite {
    int32 resp = 1;
}

message CtrlMsg_Req_OTAEnd {
}

message CtrlMsg_Resp_OTAEnd {
    int32 resp = 1;
}

message CtrlMsg_Req_VendorIEData {
    int32 element_id = 1;
    int32 length = 2;
    bytes vendor_oui = 3;
    int32 vendor_oui_type = 4;
    bytes payload = 5;
}

message CtrlMsg_Req_SetSoftAPVendorSpecificIE {
    bool enable = 1;
    Ctrl_VendorIEType type = 2;
    Ctrl_VendorIEID idx = 3;
    CtrlMsg_Req_VendorIEData vendor_ie_data = 4;
}

message CtrlMsg_Resp_SetSoftAPVendorSpecificIE {
    int32 resp = 1;
}

message CtrlMsg_Req_SetWifiMaxTxPower {
    int32 wifi_max_tx_power = 1;
}

message CtrlMsg_Resp_SetWifiMaxTxPower {
    int32 resp = 1;
}

message CtrlMsg_Req_GetWifiCurrTxPower {
}

message CtrlMsg_Resp_GetWifiCurrTxPower {
    int32 wifi_curr_tx_power = 1;
    int32 resp = 2;
}

message CtrlMsg_Req_ConfigHeartbeat {
    bool enable = 1;
    int32 duration = 2;
}

message CtrlMsg_Resp_ConfigHeartbeat {
    int32 resp = 1;
}

/** Event structure **/
message CtrlMsg_Event_ESPInit {
    bytes init_data = 1;
}

message CtrlMsg_Event_Heartbeat {
    int32 hb_num = 1;
}

message CtrlMsg_Event_StationDisconnectFromAP {
    int32 resp = 1;
}

message CtrlMsg_Event_StationDisconnectFromESPSoftAP {
    int32 resp = 1;
    bytes mac = 2;
}

message CtrlMsg {
    /* msg_type could be req, resp or Event */
    CtrlMsgType msg_type = 1;

    /* msg id */
    CtrlMsgId msg_id = 2;

    /* union of all msg ids */
    oneof payload {
        /** Requests **/
        CtrlMsg_Req_GetMacAddress req_get_mac_address = 101;
        CtrlMsg_Req_SetMacAddress req_set_mac_address = 102;
        CtrlMsg_Req_GetMode req_get_wifi_mode = 103;
        CtrlMsg_Req_SetMode req_set_wifi_mode = 104;

        CtrlMsg_Req_ScanResult req_scan_ap_list = 105;
        CtrlMsg_Req_GetAPConfig req_get_ap_config = 106;
        CtrlMsg_Req_ConnectAP req_connect_ap = 107;
        CtrlMsg_Req_GetStatus req_disconnect_ap = 108;

        CtrlMsg_Req_GetSoftAPConfig req_get_softap_config = 109;
        CtrlMsg_Req_SetSoftAPVendorSpecificIE req_set_softap_vendor_specific_ie = 110;
        CtrlMsg_Req_StartSoftAP req_start_softap = 111;
        CtrlMsg_Req_SoftAPConnectedSTA req_softap_connected_stas_list = 112;
        CtrlMsg_Req_GetStatus req_stop_softap = 113;

        CtrlMsg_Req_SetMode req_set_power_save_mode = 114;
        CtrlMsg_Req_GetMode req_get_power_save_mode = 115;

        CtrlMsg_Req_OTABegin req_ota_begin = 116;
        CtrlMsg_Req_OTAWrite req_ota_write = 117;
        CtrlMsg_Req_OTAEnd req_ota_end = 118;

        CtrlMsg_Req_SetWifiMaxTxPower req_set_wifi_max_tx_power = 119;
        CtrlMsg_Req_GetWifiCurrTxPower req_get_wifi_curr_tx_power = 120;
        CtrlMsg_Req_ConfigHeartbeat req_config_heartbeat = 121;

        /** Responses **/
        CtrlMsg_Resp_GetMacAddress resp_get_mac_address = 201;
        CtrlMsg_Resp_SetMacAddress resp_set_mac_address = 202;
        CtrlMsg_Resp_GetMode resp_get_wifi_mode = 203;
        CtrlMsg_Resp_SetMode resp_set_wifi_mode = 204;

        CtrlMsg_Resp_ScanResult resp_scan_ap_list = 205;
        CtrlMsg_Resp_GetAPConfig resp_get_ap_config = 206;
        CtrlMsg_Resp_ConnectAP resp_connect_ap = 207;
        CtrlMsg_Resp_GetStatus resp_disconnect_ap = 208;

        CtrlMsg_Resp_GetSoftAPConfig resp_get_softap_config = 209;
        CtrlMsg_Resp_SetSoftAPVendorSpecificIE resp_set_softap_vendor_specific_ie = 210;
        CtrlMsg_Resp_StartSoftAP resp_start_softap = 211;
        CtrlMsg_Resp_SoftAPConnectedSTA resp_softap_connected_stas_list = 212;
        CtrlMsg_Resp_GetStatus resp_stop_softap = 213;

        CtrlMsg_Resp_SetMode resp_set_power_save_mode = 214;
        CtrlMsg_Resp_GetMode resp_get_power_save_mode = 215;

        CtrlMsg_Resp_OTABegin resp_ota_begin = 216;
        CtrlMsg_Resp_OTAWrite resp_ota_write = 217;
        CtrlMsg_Resp_OTAEnd resp_ota_end = 218;
        CtrlMsg_Resp_SetWifiMaxTxPower resp_set_wifi_max_tx_power = 219;
        CtrlMsg_Resp_GetWifiCurrTxPower resp_get_wifi_curr_tx_power = 220;
        CtrlMsg_Resp_ConfigHeartbeat resp_config_heartbeat = 221;

        /** Notifications **/
        CtrlMsg_Event_ESPInit event_esp_init = 301;
        CtrlMsg_Event_Heartbeat event_heartbeat = 302;
        CtrlMsg_Event_StationDisconnectFromAP event_station_disconnect_from_AP = 303;
        CtrlMsg_Event_StationDisconnectFromESPSoftAP event_station_disconnect_from_ESP_SoftAP = 304;
    }
}
