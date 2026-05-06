if [ $# -ne 4 ]; then
  echo "usage: <in_file> <outfile> <lpf file> <or_ini file>"
  exit 1
fi

"/home/aliqyanabid/Downloads/efinity/2024.2/bin/efx_pgm" --source "$1" --dest "$2.hex" \
  --device "T120F324" --family "Trion" --periph "$3" \
  --interface_designer_settings "$4" --enable_external_master_clock "off" \
  --oscillator_clock_divider "DIV8" --active_capture_clk_edge "posedge" --spi_low_power_mode "on" \
  --io_weak_pullup "on" --enable_roms "smart" --mode "active" --width "1" --release_tri_then_reset "on"
