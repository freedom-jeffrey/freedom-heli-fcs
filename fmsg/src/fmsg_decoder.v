module fmsg_decoder (
  input  wire [7:0] fmsg,        // 8-bit fmsg 封包輸入
  output wire [1:0] type_out,    // 解析出的 TYPE
  output wire [1:0] dest_out,    // 解析出的 DEST
  output wire [3:0] payload_out  // 解析出的 PAYLOAD
);

  // 解碼：將 8-bit 的 fmsg 封包分為 TYPE, DEST, PAYLOAD
  assign type_out    = fmsg[7:6];  // TYPE 由 fmsg 的 bit 7 到 bit 6 提取
  assign dest_out    = fmsg[5:4];  // DEST 由 fmsg 的 bit 5 到 bit 4 提取
  assign payload_out = fmsg[3:0];  // PAYLOAD 由 fmsg 的 bit 3 到 bit 0 提取

endmodule

