`timescale 1ns / 1ns


module Priority_arbiter(
clock , // Clock
reset , // Active high reset
req_0 , // Active high request from agent 0
req_1 , // Active high request from agent 1
req_2 , // Active high request from agent 2
req_3 , // Active high request from agent 3
req_4 , // Active high request from agent 4
gnt_0 , // Active high grant to agent 0
gnt_1 , // Active high grant to agent 1
gnt_2 , // Active high grant to agent 2
gnt_3 , // Active high grant to agent 3
gnt_4   // Active high grant to agent 4
);
// Port declaration here
input clock ; // Clock
input reset ; // Active high reset
input req_0 ; // Active high request from agent 0
input req_1 ; // Active high request from agent 1
input req_2 ; // Active high request from agent 2
input req_3 ; // Active high request from agent 3
input req_4 ;
output gnt_0 ; // Active high grant to agent 0
output gnt_1 ; // Active high grant to agent 1
output gnt_2 ; // Active high grant to agent 2
output gnt_3 ; // Active high grant to agent 3
output gnt_4 ; // Active high grant to agent 4

// Internal Variables
reg gnt_0 ; // Active high grant to agent 0
reg gnt_1 ; // Active high grant to agent 1
reg gnt_2 ; // Active high grant to agent 2
reg gnt_3 ; // Active high grant to agent 3
reg gnt_4 ; // Active high grant to agent 4

reg [4:0] request;
reg [4:0] next_state;
reg [4:0] state;

// State transition logic
always @(posedge clock or posedge reset) begin
    if (reset)
        state <= 5'b00000; // Reset state to IDLE
    else
        state <= next_state;
end

// Determine next state
always @(*) begin
    case ({req_0, req_1, req_2, req_3, req_4})
        5'b00000: next_state = 5'b00000; // IDLE
        5'b00001: next_state = 5'b00001; // GNT4
        5'b00010: next_state = 5'b00010; // GNT3
        5'b00011: next_state = 5'b00010; // GNT3
        5'b00100: next_state = 5'b00100; // GNT2
        5'b00101: next_state = 5'b00100; // GNT2
        5'b00110: next_state = 5'b00100; // GNT2
        5'b00111: next_state = 5'b00100; // GNT2
        5'b01000: next_state = 5'b01000; // GNT1
        5'b01001: next_state = 5'b01000; // GNT1
        5'b01010: next_state = 5'b01000; // GNT1
        5'b01011: next_state = 5'b01000; // GNT1
        5'b01100: next_state = 5'b01000; // GNT1
        5'b01101: next_state = 5'b01000; // GNT1
        5'b01110: next_state = 5'b01000; // GNT1
        5'b01111: next_state = 5'b01000; // GNT1
        5'b10000: next_state = 5'b10000; // GNT0
        5'b10001: next_state = 5'b10000; // GNT0
        5'b10010: next_state = 5'b10000; // GNT0
        5'b10011: next_state = 5'b10000; // GNT0
        5'b10100: next_state = 5'b10000; // GNT0
        5'b10101: next_state = 5'b10000; // GNT0
        5'b10110: next_state = 5'b10000; // GNT0
        5'b10111: next_state = 5'b10000; // GNT0
        5'b11000: next_state = 5'b10000; // GNT0
        5'b11001: next_state = 5'b10000; // GNT0
        5'b11010: next_state = 5'b10000; // GNT0
        5'b11011: next_state = 5'b10000; // GNT0
        5'b11100: next_state = 5'b10000; // GNT0
        5'b11101: next_state = 5'b10000; // GNT0
        5'b11110: next_state = 5'b10000; // GNT0
        5'b11111: next_state = 5'b10000; // GNT0
        default: next_state = 5'b00000; // IDLE
    endcase
end

// Output logic
always @(posedge clock or posedge reset) begin
    if (reset) begin
        gnt_0 = 0;
        gnt_1 = 0;
        gnt_2 = 0;
        gnt_3 = 0;
        gnt_4 = 0;
    end
    else begin
        case (state)
            5'b00000: begin
                gnt_0 = 0;
                gnt_1 = 0;
                gnt_2 = 0;
                gnt_3 = 0;
                gnt_4 = 0;
                $display($time, "nano sec there is no request");
            end
            5'b10000: begin // GNT0
                gnt_0 = 1;
                gnt_1 = 0;
                gnt_2 = 0;
                gnt_3 = 0;
                gnt_4 = 0;
                $display($time, "nano sec req0 is granted");
            end
            5'b01000: begin // GNT1
                gnt_0 = 0;
                gnt_1 = 1;
                gnt_2 = 0;
                gnt_3 = 0;
                gnt_4 = 0;
                $display($time, "nano sec req1 is granted");
            end
            5'b00100: begin // GNT2
                gnt_0 = 0;
                gnt_1 = 0;
                gnt_2 = 1;
                gnt_3 = 0;
                gnt_4 = 0;
                $display($time, "nano sec req2 is granted");
            end
            5'b00010: begin // GNT3
                gnt_0 = 0;
                gnt_1 = 0;
                gnt_2 = 0;
                gnt_3 = 1;
                gnt_4 = 0;
                $display($time, "nano sec req3 is granted");
            end
            5'b00001: begin // GNT4
                gnt_0 = 0;
                gnt_1 = 0;
                gnt_2 = 0;
                gnt_3 = 0;
                gnt_4 = 1;
                $display($time, "nano sec req4 is granted");
            end
            default: begin
                gnt_0 = 0;
                gnt_1 = 0;
                gnt_2 = 0;
                gnt_3 = 0;
                gnt_4 = 0;
                $display($time, "nano sec invalid request");
            end
        endcase
    end
end
endmodule
