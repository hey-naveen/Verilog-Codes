module top_module (
    input ring,
    input vibrate_mode,
    output ringer,       // Make sound
    output motor         // Vibrate
);

    // ringer should be high when incoming call (ring = 1) and phone is not in vibrate mode (vibrate_mode = 0)
    assign ringer = ring & ~vibrate_mode;
    assign motor = ring & vibrate_mode;

endmodule
