# EEloT

## What's this?

**E**valuation toolkit for **El**ixir on I**oT** board

- install.sh: Automatically installation script for Elixir (and Erlang)
- setup.sh: Compilation and `git pull` of benchmark apps
- measure.exs: Measurement of performance (execution time) of CPU-bound apps

## Requirements

- git client
- 7z (p7zip-full)
- Package manager for Elixir installation (e.g., apt, brew)
- Of course, elixir!!

## Benchmark applications

|Name|Description|Author|Link|
|:---|:---|:---|:---|
|leibniz_formula.ex|Calculate Leibniz series formula to 10^8.|twinbee|[Qiita](https://qiita.com/hanada/items/c91788bcac2a40f1bb05#comment-b69e6585e1b86b5c03f7)|
|fibonacci_simple.ex|Calculate Fibonacci sequence number by single process. The number is set to 100_000|takatoh|[blog](http://blog.panicblanket.com/archives/3450)|
|fibonacci_process.ex|Calculate Fibonacci sequence number by distributed processing. The number and process are set to 37 and 10. This code is appeared in Sec 14.5 in [Programming Elixir 1.2](https://www.amazon.co.jp/Programming-Elixir-Functional-Concurrent-Pragmatic/dp/1937785580) written by Dave Thomas.|Dave Thomas|[Book support page](https://pragprog.com/titles/elixir12/source_code)|
|elixir_agg_csv|Elixir Flow CSV Aggregation test: this app aggregates huge CSV data by distributed streaming process.|enpedasi|[GitHub](https://github.com/enpedasi/elixir_agg_csv) [SlideShare](https://www.slideshare.net/YoshiiroUeno/elixir-go-c-x-scala-nodejs)|
|phoenix-showdown|Evaluate throughput and latency of Phoenix server.|mroth|[GitHub](https://github.com/mroth/phoenix-showdown)|

NOTE: The copyright of benchmark is attributed to developers of code. See the detail for comment out of code. I would like to thank the developers for publishing code as open source!!

If you want to use `elixir_agg_csv` and `phoenix-showdown` apps, Elixir 1.6 or later is needed. Some package system will install old version of Elixir and Erlang. You can build and install the latest version by `./install.sh souce` mode.

## Usage

### Install Elixir

```
$ ./install.sh
```
This script automatically detect OS/distribution of your system and install Elixir by package manager if you did not install it. Currently we support MacOS, Ubuntu, Raspbian.  
It should be noted that some command (e.g. apt, make install) will be done as sudo.

#### Option

```
$ ./install.sh clean
```
Clean up Elixir on your system by package manager.  

```
$ ./install.sh source
```
This option will download source code of Erlang and Elixir (to `../Elixir_Build`) and build them from source code.  
Currently this mode will install Erlang OTP 20.3 and Elixir 1.6.4.

### Setup evaluation environment

```
$ ./setup.sh
```
This script setups the evaluation environment. It compiles *.exs to beam files, and pull apps and build them.


#### Option

```
$ ./setup.sh clean
```
Clean up beam files and git directories.


### Run benchmarks

- *.ex
```
$ elixir measure.exs
```

- elixir_agg_csv
```
$ cd elixir_agg_csv/
$ iex -S mix
iex(1)> ElixirFlow.run("test_300000.csv")
iex(2)> ElixirFlow.run("test_3_000_000.csv")
```

- phoenix-showdown
```
$ cd phoenix-showdown/phoenix/benchmarker/
$ mix phoenix.server
```
On another terminal or system in same network:
```
$ wrk -t4 -c100 -d30S --timeout 2000 "http://<localhost or BoardIP>:4000/showdown"
```


## Tested IoT boards

We have already tested and evaluated on the following IoT boards.

- [Raspberry Pi 3 Model B](https://www.raspberrypi.org/products/raspberry-pi-3-model-b/)
    - Quad Core 1.2GHz Broadcom BCM2837 64bit CPU (arm Cortex-A53)
    - 1GB LPDDR2 RAM
    - BCM43438 wireless LAN and Bluetooth Low Energy (BLE) on board
    - Tested OS/distribution: 
        - [Raspbian sketch with Desktop 4.9](https://www.raspberrypi.org/downloads/raspbian/) (Raspbian GNU/Linux 9 \n \l)
        - [Ubuntu MATE 16.04](https://ubuntu-mate.org/raspberry-pi/) (Ubuntu 16.04.2 LTS \n \l)
- [ODROID-XU3](http://www.hardkernel.com/main/products/prdt_info.php?g_code=g140448267127)
    - Samsung Exynos5422 Cortex™-A15 2.0Ghz quad core and Cortex™-A7 1.4Ghz quad core CPUs
        - arm big.LITTE with a Heterogeneous Multi-Processing (HMP) solution and Dynamic Voltage and Frequecy Scaling (DVFS) support.
    - Mali-T628 MP6(OpenGL ES 3.0/2.0/1.1 and OpenCL 1.1 Full profile)
    - 2Gbyte LPDDR3 RAM at 933MHz (14.9GB/s memory bandwidth)
    - 10/100Mbps Ethernet with RJ-45 Jack
        - We use WLI-UC-G301N USB-WiFi adaptor to connect the network.
    - Tested OS/distribution: 
        - [ubuntu-16.04-mate-odroid-xu3-20170731](http://odroid.com/dokuwiki/doku.php?id=en:xu3_release_linux_ubuntu) (Ubuntu 16.04.4 LTS \n \l)
- [ZYBO](https://japan.xilinx.com/products/boards-and-kits/1-4azfte.html)
    - Xilinx Zynq-7000 (XC7Z010-1CLG400C)
        - 650 MHz dual-core Cortex™-A9 processor
        - 512 MB x32 DDR3 w/ 1050Mbps bandwidth
        - FPGA fabric: 28,000 logic cells / 240 KB Block RAM
    - Trimode (1Gbit/100Mbit/10Mbit) Ethernet PHY
    - Tested OS/distribution: 
        - [Xillinux-2.0](http://xillybus.com/xillinux) (Ubuntu 16.04 LTS \n \l)
- Reference: MacBook Pro (2016)
    - Intel Core i7-6567U dual-core CPU @ 3.3 GHz (4-threads)
    - 16GB 2133 MHz LPDDR3
    - Intel Iris Graphics 550 1536 MB
    - macOS High Sierra 10.13.4

### Summary of specification

| Board | OS | Core | Memory | Network |
|:---|:---|:---|:---|:---|
| RaspberryPi3B | Raspbian Desktop 4.9 | 4x 1.2GHz Cortex-A53 | 1GB LPDDR2 | 150Mbps 2.4GHz 802.11b/g/n WiFi |
|  | Ubuntu MATE 16.04 |  |  |  |
| ODROID-XU3 | Ubuntu MATE 16.04 | 4x 2.0GHz Cortex-A15 + 4x 1.4GHz Cortex-A7 | 2GB LPDDR3 | 300Mbps 2.4GHz 802.11n/g/b WiFi |
| ZYBO | Xillinux-2.0 | 2x 650MHz Cortex-A9 | 512MB DDR3 | 1GBit Ethernet PHY |
| MacBook Pro | macOS High Sierra 10.13.4 | 2x 3.3GHz Core i7 (4-threads) | 16GB LPDDR3 | 433.3Mbps 5.0GHz 802.11ac/b/g/n WiFi |

## Evaluation results @2018-04-18

Please PR if you have evaluated another IoT boards!!

### *.exs

|Board|OS|leibniz_formula|fibonacci_simple|fibonacci_process|
|:---|:---|---:|---:|---:|
|RaspberryPi3B|Raspbian| 118.174 | 9.516 | 15.320 |
| |Ubuntu| 119.010 | 5.084 | 15.910 |
|ODROID-XU3|Ubuntu| 50.749 | 7.858 | 6.958 |
|ZYBO|Ubuntu| 159.950 | *1 | 41.793 |
|MacBook Pro|High Sierra| 7.584 | 2.260 | 3.065 |

[unit: second]

*1: ZYBO could not run fibonacci_simple due to memory limitation. (`eheap_alloc: Cannot allocate 220742620 bytes of memory (of type "old_heap").`)

### elixir_agg_csv

|Board|OS|test_300000.csv|test_3_000_000.csv|
|:---|:---|---:|---:|
|RaspberryPi3B|Raspbian| 9.317 | 82.720 |
| |Ubuntu| 9.294 | 82.880 |
|ODROID-XU3|Ubuntu| 4.704 | 46.552 |
|ZYBO|Ubuntu| 30.170 | 285.469 |
|MacBook Pro|High Sierra| 1.958 | 22.798 |

[unit: second]


### phoenix-showdown

|Board|OS|Throughput [req/s]|Latency [s]|Consistency [σ ms]|
|:---|:---|---:|---:|---:|
|RaspberryPi3B|Raspbian| 80.05 | 1.21 | 231.84 |
| |Ubuntu| 74.47 | 1.28 | 242.29 |
|ODROID-XU3|Ubuntu| 41.27 | 1.94 | 439.83 |
|ZYBO|Ubuntu| 26.17 | 3.54 | 817.82 |
|MacBook Pro|High Sierra| 290.42 | 0.341 | 78.20 |

NOTE: Evaluation of `wrk` has been done from MacBook Pro on same network (to `http://<BoardIP>:4000/`). ZYBO was connect via ethernet cable and others were via WiFi by relaying Buffalo WCR-1166DS router.

## Changelog

- 2018-04-18: Published to 1st evaluation results

Please PR if you have evaluated another IoT boards!!

## License

Basically [MIT License](https://opensource.org/licenses/MIT), but the copyright of `*.ex` files is attributed to developers of code. See the detail for comment out of code.

## Related links

- [fukuoka.ex#8](https://fukuokaex.connpass.com/event/85038/): Elixir User Group Meeting vol.8 at Fukuoka, Japan
- [SlideShare Docs (in Japanese)](https://www.slideshare.net/takasehideki/elixiriot-biglittlezynq-94455098)

