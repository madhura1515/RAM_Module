module ram #(
  parameter DATA_WIDTH = 8,
  parameter ADDR_WIDTH = 4,
  parameter RAM_DEPTH = 1 << ADDR_WIDTH // Calculate RAM depth based on address width
)(
  input clk,
  input we,      // Write enable
  input [ADDR_WIDTH-1:0] addr,
  input [DATA_WIDTH-1:0] data_in,
  output reg [DATA_WIDTH-1:0] data_out
);

  reg [DATA_WIDTH-1:0] mem [0:RAM_DEPTH-1];

  always @(posedge clk) begin
    if (we) begin
      mem[addr] <= data_in; // Write operation
    end
    data_out <= mem[addr]; // Read operation (always happens on clock edge)
  end

endmodule