/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_pwmet (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);
    pwm #(.bits(4)) C (
        .clk(ui_in[0]),
        .rst(ui_in[1]),
        .sw(ui_in[5:2]),
        .pwm(uo_out[0])
    );
  // All output pins must be assigned. If not used, assign to 0.
    assign uo_out [7:1] = 7'b0000000;  // Example: ou_out is the sum of ui_in and uio_in
    assign uio_out [7:0]= 8'b00000000;
    assign uio_oe  [7:0]= 8'b00000000;

  // List all unused inputs to prevent warnings
    wire _unused = &{ena, clk, rst_n, ui_in[7:6], uio_in[7:0]};

endmodule
