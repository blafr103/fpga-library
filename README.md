# FPGA Library

Reusable SystemVerilog building blocks written while learning FPGA design. Modules are simulated with Icarus Verilog and written for Intel Quartus on a Terasic SoCKit (Cyclone V).

## Modules

All modules so far are combinational (no clock).

| Module | File | Description |
| --- | --- | --- |
| `half_adder` | `src/combinational/arithmetic/half_adder.sv` | 1-bit half adder |
| `full_adder` | `src/combinational/arithmetic/full_adder.sv` | 1-bit full adder with carry in |
| `ripple_adder` | `src/combinational/arithmetic/ripple_adder.sv` | Parameterized ripple-carry adder built from `full_adder`, with carry out and signed overflow flag |
| `comparator` | `src/combinational/arithmetic/comparator.sv` | Parameterized unsigned magnitude comparator (`gt`, `eq`, `lt`) |
| `decoder2to4` | `src/combinational/converters/decoder2to4.sv` | 2-to-4 decoder with enable |
| `encoder4to2` | `src/combinational/converters/encoder4to2.sv` | One-hot 4-to-2 encoder with valid flag |
| `priority_encoder4` | `src/combinational/converters/priority_encoder4.sv` | 4-to-2 priority encoder, highest index wins |
| `mux2` | `src/combinational/mux/mux2.sv` | 2-to-1 multiplexer |
| `mux4_behavioral` | `src/combinational/mux/mux4_behavioral.sv` | 4-to-1 multiplexer, behavioral |
| `mux4_structural` | `src/combinational/mux/mux4_structural.sv` | 4-to-1 multiplexer built from three `mux2` |
| `alu` | `src/combinational/datapath/alu.sv` | Parameterized ALU with the RV32I integer operations (ADD, SUB, AND, OR, XOR, SLT, SLTU, SLL, SRL, SRA) and a zero flag |

Testbenches live in `tb/`, named `<module>_tb.sv`. So far only `mux2` has one.

## Simulating

```bash
iverilog -g2012 -o mux2_tb.vvp src/combinational/mux/mux2.sv tb/mux2_tb.sv
vvp mux2_tb.vvp
```

Modules built from other modules need those files on the command line too: `ripple_adder` needs `full_adder.sv`, and `mux4_structural` needs `mux2.sv`.

Icarus prints `sorry: constant selects in always_* processes are not currently supported` for `priority_encoder4` and `alu`. That's a known Icarus limitation: it watches the whole input vector instead of the selected bits, which doesn't change the results.

## Conventions

- One module per file, file named after the module
- Parameters in ALL_CAPS
- Clocked modules use an active-low synchronous reset, `rst_n`
- Port order: `clk`, `rst_n`, `en`, then inputs, then outputs

## Roadmap

Planned structure as the library grows. So far only `src/combinational/` (arithmetic, converters, datapath, mux) and `tb/` exist.

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
├── tb/                           # verification - mirror the src/ tree
│   └── common/                   # reusable verif IP: driver, monitor, scoreboard, coverage, SVA
├── fpga/                         # board-specific: constraints (.sdc/.qsf), pin maps, top wrappers
├── formal/                       # formal properties (SVA), if pursued
├── docs/
└── README.md

```
