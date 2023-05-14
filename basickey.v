// MODIFICADO 25/02/2023 FOR JC GUTIERREZ
// KEY&LED TM1638 QYF MOD


module top(
    input clk,
    output reg [7:0]led,
    output reg tm_cs,
    output tm_clk,
    inout  tm_dio
    );
   
    localparam 
        HIGH    = 1'b1,
        LOW     = 1'b0;
    reg [7:0] segm1=  8'b11111111;  //a  activo segs visualizo 0  todos los displays           
    reg [7:0] segm2=  8'b11111111;  //b
    reg [7:0] segm3=  8'b11111111;  //c
    reg [7:0] segm4=  8'b11111111;  //d
    reg [7:0] segm5=  8'b11111111;  //e 
    reg [7:0] segm6=  8'b11111111;  //f
    reg [7:0] segm7=  8'b00000000;  //g
    reg [7:0] segm8=  8'b00000000;  //g
    
    reg [7:0] digit1=  8'b11111110;  //dig1  activo display
    reg [7:0] digit2=  8'b11111101;  //dig2
    reg [7:0] digit3=  8'b11111011;  //dig3
    reg [7:0] digit4=  8'b11110111;  //dig4
    reg [7:0] digit5=  8'b11101111;  //dig5   
    reg [7:0] digit6=  8'b11011111;  //dig6
    reg [7:0] digit7=  8'b10111111;  //dig7
    reg [7:0] digit8=  8'b01111111;  //dig8
   
    reg [7:0] data1;
    reg [7:0] data2;
    reg [7:0] data3;
    reg [7:0] data4;
    reg [7:0] data5;
    reg [7:0] data6;
    reg [7:0] data7;
    reg [7:0] data8;


 

    clock_divider #(.COUNT_WIDTH(27), .MAX_COUNT(90000)) div1 (.clk2(clk), .rst(rst), .out(div_clk));
    localparam [7:0]
        C_READ  = 8'b01000010,
        C_WRITE = 8'b01000000,
        C_DISP  = 8'b10001111,
        C_ADDR  = 8'b11000000;


    localparam CLK_DIV = 5; // speed of scanner
    reg rst = HIGH;
    reg [7:0] LED_out; 
   
    reg [5:0] instruction_step;
    reg [7:0] keys;
    reg [7:0] keysb;
  
    reg [CLK_DIV:0] counter;

    // set up tristate IO pin for display
    //   tm_dio     is physical pin
    //   dio_in     for reading from display
    //   dio_out    for sending to display
    //   tm_rw      selects input or output
    reg tm_rw;
    wire dio_in, dio_out;
    SB_IO #(
        .PIN_TYPE(6'b101001),
        .PULLUP(1'b1)
    ) tm_dio_io (
        .PACKAGE_PIN(tm_dio),
        .OUTPUT_ENABLE(tm_rw),
        .D_IN_0(dio_in),
        .D_OUT_0(dio_out)
    );
    
      //------------numero segmento-------------------------------------------------
              always @(posedge div_clk)begin
    {segm8[0],segm7[0],segm6[0],segm5[0],segm4[0],segm3[0],segm2[0],segm1[0]} =data1;
    {segm8[1],segm7[1],segm6[1],segm5[1],segm4[1],segm3[1],segm2[1],segm1[1]} =data2;
    {segm8[2],segm7[2],segm6[2],segm5[2],segm4[2],segm3[2],segm2[2],segm1[2]} =data3;
    {segm8[3],segm7[3],segm6[3],segm5[3],segm4[3],segm3[3],segm2[3],segm1[3]} =data4;
    {segm8[4],segm7[4],segm6[4],segm5[4],segm4[4],segm3[4],segm2[4],segm1[4]} =data5;
    {segm8[5],segm7[5],segm6[5],segm5[5],segm4[5],segm3[5],segm2[5],segm1[5]} =data6;
    {segm8[6],segm7[6],segm6[6],segm5[6],segm4[6],segm3[6],segm2[6],segm1[6]} =data7;
    {segm8[7],segm7[7],segm6[7],segm5[7],segm4[7],segm3[7],segm2[7],segm1[7]} =data8;
 
              end 
    //   tm1638-QYF module with it's tristate IO
    //   tm_in      is read from module
    //   tm_out     is written to module
    //   tm_latch   triggers the module to read/write display
    //   tm_rw      selects read or write mode to display
    //   busy       indicates when module is busy
    //                (another latch will interrupt)
    //   tm_clk     is the data clk
    //   dio_in     for reading from display
    //   dio_out    for sending to display
    //
    //   tm_data    the tristate io pin to module
    reg tm_latch;
    wire busy;
    wire [7:0] tm_data, tm_in;
    reg [7:0] tm_out;

    assign tm_in = tm_data;
    assign tm_data = tm_rw ? tm_out : 8'hZZ;

    tm1638 u_tm1638 (
        .clk(clk),
        .rst(rst),
        .data_latch(tm_latch),
        .data(tm_data),
        .rw(tm_rw),
        .busy(busy),
        .sclk(tm_clk),
        .dio_in(dio_in),
        .dio_out(dio_out)
    );

            always @(posedge div_clk)begin
           
               if (keys)begin
                  data1=  LED_out; //* 1 */

               end else
              if (keysb)begin
                  data1=  LED_out; //* 1 */

                end
              	//--------------------------------keys to keysb-------------------------------------------

    begin 
        case (keys)
      
       8'b00000001: LED_out =  7'b0111111; /* 0 */
       8'b00000010: LED_out =  7'b0000110; /* 1 */
       8'b00000100: LED_out =  7'b1011011; /* 2 */
	   8'b00001000: LED_out =  7'b1001111; /* 3 */
	   8'b00010000: LED_out =  7'b1100110; /* 4 */
	   8'b00100000: LED_out =  7'b1101101; /* 5 */
  	   8'b01000000: LED_out =  7'b1111101; /* 6 */
	   8'b10000000: LED_out =  7'b0000111; /* 7 */
  	      
 
        endcase  
    end begin

     case (keysb)
      
      
       8'b00000001: LED_out =  7'b1111111;  // 8
       8'b00000010: LED_out =  7'b1101111;  // 9 
       8'b00000100: LED_out =  7'b1110111;  // A 
  	   8'b00001000: LED_out =  7'b1111100;  // B 
  	   8'b00010000: LED_out =  7'b0111001;  // C 
	   8'b00100000: LED_out =  7'b1011110;  // D 
       8'b01000000: LED_out =  7'b1111001;  // E 
	   8'b10000000: LED_out =  7'b1110001;  // F        
          
        endcase  
    end
         led=keys||keysb;
         
        end    

  

    always @(posedge clk) begin
        if (rst) begin
            instruction_step <= 6'b0;
            tm_cs <= HIGH;
            tm_rw <= HIGH;
            rst <= LOW;

            counter <= 0;
            keys <= 8'b0;
           

        end

            if (counter[0] && ~busy) begin
                case (instruction_step)
                    // *** KEYS ***
                    1:  {tm_cs, tm_rw}     <= {LOW, HIGH};
                    2:  {tm_latch, tm_out} <= {HIGH, C_READ}; // read mode
                    3:  {tm_latch, tm_rw}  <= {HIGH, LOW};

                    //  read back keys S1 - S8
                 
                    4:   {keysb[0], keysb[1],keys[0], keys[1]}       <=  {tm_in[1], tm_in[5],tm_in[2], tm_in[6]};
                    5:   {tm_latch}               <=  {HIGH};
                    6:   {keysb[2], keysb[3],keys[2], keys[3]}       <=  {tm_in[1], tm_in[5],tm_in[2], tm_in[6]};
                    7:   {tm_latch}               <=  {HIGH};
                    8:   {keysb[4], keysb[5],keys[4], keys[5]}       <=  {tm_in[1], tm_in[5],tm_in[2], tm_in[6]};
                    9:   {tm_latch}               <=  {HIGH};
                    10:  {keysb[6], keysb[7],keys[6], keys[7]}       <=  {tm_in[1], tm_in[5],tm_in[2], tm_in[6]};
                    
                    
                 
                   

                    20: {tm_cs}            <= {HIGH};

                    // *** DISPLAY ***
                    21: {tm_cs, tm_rw}     <= {LOW, HIGH};
                    22: {tm_latch, tm_out} <= {HIGH, C_WRITE}; // write mode
                    23: {tm_cs}            <= {HIGH};

                    24: {tm_cs, tm_rw}     <= {LOW, HIGH};
                    25: {tm_latch, tm_out} <= {HIGH, C_ADDR}; // set addr 0 pos

                    26: {tm_latch, tm_out} <= {HIGH, { segm1}};   // LED  1----a
                    27: {tm_latch, tm_out} <= {HIGH, { digit1}};  // disp 1
                       
                    28: {tm_latch, tm_out} <= {HIGH, { segm2}};   // LED  2----b
                    29: {tm_latch, tm_out} <= {HIGH, { digit2}};  // disp 2
                      
                    30: {tm_latch, tm_out} <= {HIGH, { segm3}};   // LED  3----c
                    31: {tm_latch, tm_out} <= {HIGH, { digit3}};  // disp 3
                     
                    32: {tm_latch, tm_out} <= {HIGH, { segm4}};   // LED  4----d
                    33: {tm_latch, tm_out} <= {HIGH, { digit4}};  // disp 4

                    34: {tm_latch, tm_out} <= {HIGH, { segm5}};   // LED  5----e
                    35: {tm_latch, tm_out} <= {HIGH, { digit5}};  // disp 5
                       
                    36: {tm_latch, tm_out} <= {HIGH, { segm6}};   // LED  6----f
                    37: {tm_latch, tm_out} <= {HIGH, { digit6}};  // disp 6

                    38: {tm_latch, tm_out} <= {HIGH, { segm7}};   // LED  7----g
                    39: {tm_latch, tm_out} <= {HIGH, { digit7}};  // disp 7

                    40: {tm_latch, tm_out} <= {HIGH, { segm8}};   // LED  8----h
                    41: {tm_latch, tm_out} <= {HIGH, { digit8}};  // disp 8
                     
                    42: {tm_cs}            <= {HIGH};

                    43: {tm_cs, tm_rw}     <= {LOW, HIGH};
                    44: {tm_latch, tm_out} <= {HIGH, {C_DISP}}; // display
                    45: {tm_cs, instruction_step} <= {HIGH, 6'b0};

                    endcase
               
                   instruction_step <= instruction_step + 1;

            end else if (busy) begin
                // pull latch low next clock cycle after module has been
                // latched
                tm_latch <= LOW;
            end

            counter <= counter + 1;
        end
  
            
     
   
 
endmodule
