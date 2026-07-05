# FPGA Library

Reusable SystemVerilog hardware modules developed while studying FPGA design.

## Repo Structure

```
.
├── src/
│   ├── combinational/     # stateless logic (no clock)
│   │   ├── arithmetic/           # adders, subtractors, multipliers, dividers, comparators
│   │   ├── logic/                # bitwise / reduction primitives
│   │   ├── mux/                  # muxes, demuxes
│   │   ├── converters/           # encoders, decoders, code converters (gray/BCD/one-hot)
│   │   ├── shift/                # combinational (barrel) shifters
│   │   └── datapath/             # composite stateless units (ALU)
│   ├── sequential/        # clocked logic (has state)
│   │   ├── registers/            # DFF, register, shift register, register file
│   │   ├── counters/             # up/down, ring, Johnson, LFSR, gray, BCD
│   │   ├── fsm/                  # FSM templates + FSM-driven controllers
│   │   ├── memory/               # RAM, ROM, FIFO
│   │   ├── cdc/                  # synchronizers, edge/pulse, debounce, clock div, reset sync
│   │   └── datapath/             # composite clocked units (accumulator, MAC, seq mul/div)
│   ├── soc/               # integrated systems (span combinational + sequential)
│   │   ├── core/                 # RISC-V CPU and its sub-blocks
│   │   ├── peripherals/          # UART, SPI, I2C, GPIO, timer, PWM, IRQ controller
│   │   ├── interconnect/         # arbiters, crossbars, bus fabric
│   │   └── top/                  # SoC top-level integration
│   ├── pkg/               # shared packages: types, params, opcode enums (not modules)
│   └── interface/                # SystemVerilog interfaces: AXI-Lite, APB, custom handshake
├── tb/                           # verification — mirror the src/ tree
│   └── common/                   # reusable verif IP: driver, monitor, scoreboard, coverage, SVA
├── fpga/                         # board-specific: constraints (.sdc/.qsf), pin maps, top wrappers
├── formal/                       # formal properties (SVA), if pursued
├── docs/
└── README.md

```
