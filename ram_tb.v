module ram_tb;
  reg clk;
  reg we;
  reg [3:0] addr;
  reg [7:0] data_in;
  wire [7:0] data_out;

  ram #(
    .DATA_WIDTH(8),
    .ADDR_WIDTH(4)
  ) ram_inst (
    .clk(clk),
    .we(we),
    .addr(addr),
    .data_in(data_in),
    .data_out(data_out)
  );

  initial begin
    clk = 0;
    forever #5 clk = ~clk; // Clock generation
  end

  initial begin
    // Test sequence
    we = 0; addr = 0; data_in = 0; #10; // Initialization

    // Write operations
    we = 1; addr = 0; data_in = 8'hAA; #10;
    we = 1; addr = 1; data_in = 8'hBB; #10;
    we = 1; addr = 2; data_in = 8'hCC; #10;
    we = 1; addr = 0; data_in = 8'hDD; #10; //overwrite address 0

    // Read operations
    we = 0; addr = 0; #10;
    we = 0; addr = 1; #10;
    we = 0; addr = 2; #10;
    we = 0; addr = 0; #10;

    $finish;
  end

  initial begin
    $monitor("Time=%0t clk=%b we=%b addr=%h data_in=%h data_out=%h", $time, clk, we, addr, data_in, data_out);
    $dumpfile("ram.vcd");
    $dumpvars(0, ram_tb);
  end

endmodule