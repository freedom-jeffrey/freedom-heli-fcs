// iverilog -o sim tb_fmsg_to_ice40.v ../src/fmsg_decoder.v 
// vvp sim

module tb_fmsg_to_ice40;

  reg [7:0] fmsg_in;       // fmsg 封包輸入
  wire [1:0] type_out;     // 解碼後的 TYPE
  wire [1:0] dest_out;     // 解碼後的 DEST
  wire [3:0] payload_out;  // 解碼後的 PAYLOAD

  // 實例化 ICE40 解碼器
  fmsg_decoder dut (
    .fmsg(fmsg_in),
    .type_out(type_out),
    .dest_out(dest_out),
    .payload_out(payload_out)
  );

  // 測試邏輯，包含結果驗證
  initial begin
    // 測試 1: TYPE = 01, DEST = 10, PAYLOAD = 1111
    fmsg_in = 8'b01101111; #10;
    if (type_out == 2'b01) $display("TEST 1 Passed: TYPE 2'b%b == 2'b01", type_out); else $fatal(1, "TEST 1 FAILED: TYPE = %b (expected 01)", type_out);
    if (dest_out == 2'b10) $display("TEST 1 Passed: DEST 2'b%b == 2'b10", dest_out); else $fatal(1, "TEST 1 FAILED: DEST = %b (expected 10)", dest_out);
    if (payload_out == 4'b1111) $display("TEST 1 Passed: PAYLOAD 4'b%b == 4'b1111", payload_out); else $fatal(1, "TEST 1 FAILED: PAYLOAD = %b (expected 1111)", payload_out);

    // 測試 2: TYPE = 11, DEST = 00, PAYLOAD = 0001
    fmsg_in = 8'b11000001; #10;
    if (type_out == 2'b11) ; else $fatal(1, "TEST 2 FAILED: TYPE = %b (expected 11)", type_out);
    if (dest_out == 2'b00) ; else $fatal(1, "TEST 2 FAILED: DEST = %b (expected 00)", dest_out);
    if (payload_out == 4'b0001) ; else $fatal(1, "TEST 2 FAILED: PAYLOAD = %b (expected 0001)", payload_out);

    // 測試 3: TYPE = 00, DEST = 01, PAYLOAD = 1010
    fmsg_in = 8'b00011010; #10;
    if (type_out == 2'b00) ; else $fatal(1, "TEST 3 FAILED: TYPE = %b (expected 00)", type_out);
    if (dest_out == 2'b01) ; else $fatal(1, "TEST 3 FAILED: DEST = %b (expected 01)", dest_out);
    if (payload_out == 4'b1010) ; else $fatal(1, "TEST 3 FAILED: PAYLOAD = %b (expected 1010)", payload_out);

    // 所有測試通過
    $display("All tests passed!");
    $finish;
  end

endmodule


