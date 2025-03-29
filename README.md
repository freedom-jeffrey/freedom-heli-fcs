# Freedom Heli

**Federated Heterogeneous Flight Control System**

**聯邦式異構飛控系統**

**Freedom Heli** is a real-time flight control architecture built for high reliability, transparency, and modularity.  
It adopts a **federated modular design**, where each processing core (MCU, DSP, FPGA, Propeller) is responsible for an independent function.

**Freedom Heli** 專為高可靠、可追蹤、模組化的即時飛行控制而設計

核心架構採用聯邦式異構分工，每個 processing core (MCU、DSP、FPGA、Propeller) 負責一個獨立的功能

🚨 This project is under active development and is not a finished product.

This project is not derived from PX4, ArduPilot, or any RTOS-based framework.  
It is implemented in **bare-metal, from scratch**, for full control of timing and logic.

本專案非以 PX4、ArduPilot 為基礎，也未使用任何即時作業系統（RTOS），  
而是以裸機（bare-metal）方式獨立實作，確保對每一條執行邏輯與時序皆可追責。

All source code and architecture were publicly released as **defensive prior art**, assisted by ChatGPT,  
to block future enclosure and ensure it remains open and legally reusable.

本專案所有設計與程式碼均已公開，並透過 ChatGPT 協助構成技術先例（prior art），  
防止未來任何第三方進行封閉化專利壟斷，確保架構自由可用。

---

## 🧠 Core Architecture

A distributed heterogeneous system:

- **Cortex-M4 (MCU)** — runs bare-metal EKF and control loop, sub-1ms latency
- **dsPIC33 (DSP)** — handles sensor math, digital filtering, math assist
- **ICE40 (FPGA)** — generates PWM, captures IMU signals, handles safety overrides
- **P8X32A (Propeller)** — supports time-isolated tasks, such as parallel sensor interpretation or fallback safety logic


All processors operate independently under a federated design.  
No operating system is used.  
The system is implemented entirely in bare-metal C/C++ to ensure deterministic timing and full control of execution flow.

---

## 🛰️ Federated Modular Architecture

**Freedom Heli** adopts a **federated modular architecture**, explicitly avoiding any single point of control.

Each processor in the Freedom Heli architecture is assigned an independent role with minimal cross-dependence:

- **Cortex-M4 (MCU)** runs core state estimation (e.g., EKF) and executes the main flight control loop  
- **dsPIC33 (DSP)** handles math-heavy signal preprocessing and sensor filtering, but is not required for EKF  
- **ICE40 (FPGA)** manages deterministic timing, generates PWM, and can override outputs in critical conditions  
- **P8X32A (Propeller)** handles parallel utility tasks and redundant fallback logic independently

<br/>

- The MCU does not depend on the DSP for state estimation  
- The FPGA can assert control even if both MCU and DSP fail  
- Logging and fallback mechanisms are managed locally within each unit

> We don’t build “one core to rule them all” <br/>
> We build a system that **fails predictably**, **explains failure**, and **keeps flying when others can’t**.


---


## E-LoC: Explainable Loss-of-Control

**Freedom Heli** includes a design principle where any loss-of-control condition must be logged, explained, and later auditable.

- All flight control modules are expected to report abnormal states with context
- Logs are structured, human-readable, and machine-verifiable
- A visualization tool ("E-LoCView") is planned to assist in post-event analysis


---

## 📁 Modules

| Path            | Description                                      |
|-----------------|--------------------------------------------------|
| `mcu/`          | Bare-metal control loop on **Cortex-M4 (MCU)**, performs core state estimation (EKF) and flight control |
| `dsp/`          | Signal preprocessing and math-heavy filtering on **dsPIC33 (DSP)**, not required for EKF |
| `fpga/`         | Timing management, PWM generation, and critical condition overrides on **ICE40 (FPGA)** |
| `p8x32a/`       | Handles parallel utility tasks and redundant logic on **P8X32A (Propeller)** |
| `eloc/`         | Logging core for every instability trigger       |
| `elocview/`     | Timeline visualizer and failure reconstructor    |


---

## 🛡️ Patent Defensive Declaration | 防禦性專利聲明

This repository and its architecture were developed with technical assistance from ChatGPT.  
The structure, modular roles, and E-LoC were created and documented here as a **public defensive publication**.  
This serves as **prior art** and may not be patented or enclosed by any third party in the future.

本專案之架構設計與模組分工，在 ChatGPT 輔助下形成並公開發布，  
屬於防禦性公開技術（Defensive Publication），已構成 Prior Art，  
任何人不得以本架構為基礎申請專利或進行封閉化佔有。

---

## 🛠️ Status & 🚨 Notice

**We are not releasing a finished product.**  
**Freedom Heli** is an ongoing project, built as a foundation for future development, not a ready-to-fly solution.


