# FMSG (Freedom Messaging System)

**FMSG** 是 Freedom Heli FCS 的內部訊息系統，設計目標為：

- Fire-and-forget, One-way communication
- 超低延遲、零依賴（不需要 ACK / 不握手）
- 適用於 MCU / FPGA / DSP 間的即時資料轉送
- 具備簡單封包格式與分流邏輯，可延伸為分散式 Bus

目前版本：v0.1  
封包大小：1 byte（8 bit）
