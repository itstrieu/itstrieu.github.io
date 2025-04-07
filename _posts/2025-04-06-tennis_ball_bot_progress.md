---
title: Tennis Ball Bot Progress
date: 2025-04-06
layout: post
tags:
 - Machine
 - Learning
 - AI
 - Career
 - Robotics
 - Object
 - Detection
 - Computer
 - Vision
 - YOLO
 - Tennis
description: A personal reflection on building a tennis ball–retrieving robot using machine learning and robotics from the ground up.
image: pi.jpg
---

This project began when a group of mechanical engineering friends came to me with an idea: build a robot that could find and retrieve tennis balls. They had the hardware vision but needed someone with programming and machine learning skills to bring it to life. It felt exciting—but also almost unreachable. Robotics was unfamiliar terrain, so I decided to start where I felt some footing: computer vision.

Right now, I’m fine-tuning a YOLOv8n model to detect tennis balls. I collected my own dataset and recently finished training the first solid version. The model is performing well on the validation set, with best weights showing over 92% recall and over 96% precision. I’m now doing error analysis to see where it struggles—especially in tricky or real-world conditions—so I can keep improving it before deploying to the HAiLO AI accelerator. Spending this much time on error analysis has been helpful. It’s forcing me to notice edge cases and understand model training better.

![Validation Set Predictions](https://github.com/itstrieu/itstrieu.github.io/blob/main/assets/img/val_batch2_pred.jpg?raw=true)

Lately, I’ve been deeply involved with hardware: programming movement using omnidirectional wheels, testing encoder DC motors, and troubleshooting all the unpredictable behaviors that come with real-world components. I recently hit a milestone that felt like a real turning point: I built a motion controller that actually works. We cheered when the robot completed each direction we programmed for it from forward movement to strafing right. I also wrote a centralized logger so I could track what each wheel was doing in real time. 

![Tennis Ball Bot Prototype](https://github.com/user-attachments/assets/3e39787b-551c-4f2c-b1a6-3052a9e0be3f)

```python
class MotionController:
    def __init__(self):
        """
        Initialize the motion controller.

        - Sets up the logger for the motion control module.
        - Claims GPIO control for the motor-related pins.
        """
        # Set up the logger
        motion_logger = Logger(name="motion", log_level=logging.INFO)
        self.logger = motion_logger.get_logger()

        self.chip = lgpio.gpiochip_open(0)  # Open GPIO chip 0
        self.stby = STBY  # Pin that enables/disables motor driver

        # Motor pin groups for each wheel (IN1, IN2, PWM)
        self.motors = {
            "FL": FRONT_LEFT,  # Front Left
            "FR": FRONT_RIGHT,  # Front Right
            "RL": REAR_LEFT,  # Rear Left
            "RR": REAR_RIGHT,  # Rear Right
        }

        # Direction patterns for movement
        self.patterns = {
            "forward": {"FL": 1, "FR": 1, "RL": 1, "RR": 1},
            "backward": {"FL": -1, "FR": -1, "RL": -1, "RR": -1},
            "strafe_left": {"FL": -1, "FR": 1, "RL": 1, "RR": -1},
            "strafe_right": {"FL": 1, "FR": -1, "RL": -1, "RR": 1},
            "rotate_left": {"FL": -1, "FR": 1, "RL": -1, "RR": 1},
            "rotate_right": {"FL": 1, "FR": -1, "RL": 1, "RR": -1},
            "diagonal_fr": {"FL": 1.0, "FR": 0.5, "RL": 0.5, "RR": 1.0},
            "diagonal_fl": {"FL": 0.5, "FR": 1.0, "RL": 1.0, "RR": 0.5},
            "diagonal_br": {"FL": -0.5, "FR": -1.0, "RL": -1.0, "RR": -0.5},
            "diagonal_bl": {"FL": -1.0, "FR": -0.5, "RL": -0.5, "RR": -1.0},
        }

        # Claim GPIO control over all motor-related pins
        self._claim_output_pins()
```

This phase has been messy. I’ve spent hours debugging motors that turned out to have a single miswired pin or a loose ground connection. But I’ve also started to feel like I’m building something real. I refactored the codebase into cleaner modules: `navigation`, `detection`, `sensors`, `strategy`, etc. &#x20;

Integration is next: connecting the object detection model to the robot’s control logic and sensor input so it can start making actual decisions. I’m planning to use bounding box size and location to estimate object distance and direction, while using ultrasonic sensors to avoid collisions or stop at just the right distance.

```markdown
│   ├── core/                        # Core functionality of the robot
│   │   ├── __init__.py              # Marks this folder as a package
│   │   ├── navigation/              # Navigation and motion control logic
│   │   │   ├── __init__.py          # Marks this folder as a package
│   │   │   ├── encoders.py          # Encoder-related logic
│   │   │   └── motion_controller.py # Controls motor movement and direction
│   │   │
│   │   ├── detection/               # Object detection (YOLO) logic
│   │   │   ├── __init__.py          # Marks this folder as a package
│   │   │   ├── vision_tracker.py    # Tracks and handles object detection
│   │   │   └── yolo_inference.py    # YOLO inference for real-time object detection
│   │   │
│   │   ├── sensors/                 # Sensor control and integration
│   │   │   ├── __init__.py          # Marks this folder as a package
│   │   │   └── ultrasonic_sensor.py # Ultrasonic sensor for distance measurement
│   │   │
│   │   ├── strategy/                # AI decision-making logic
│   │   │   ├── __init__.py          # Marks this folder as a package
│   │   │   ├── movement_decider.py  # Decides robot movement strategy
│   │   │   └── __init__.py          # Marks this folder as a package
│   │   │
│   │   └── streaming/               # Streaming and remote access components
│   │       ├── __init__.py          # Marks this folder as a package
│   │       ├── camera_streamer.py   # Manages camera feed streaming
│   │       ├── performance_monitor.py # Monitors system performance in real-time
│   │       └── stream_client.py     # Handles communication with streaming services
```

A big part of what’s kept me going is how much this project is teaching me about *how* I learn. Early on, I used large language models to help generate basic test scripts and wire up examples. That was helpful, but surface-level. Now, I often start high-level—thinking through design choices like class structure, logic flow, and how I want the code to behave. Then I’ll use large language models to help scaffold that vision into actual code. Having that kind of sounding board has made me more deliberate and confident in how I architect things.\
![Motion Controller Skeleton generated by ChatGPT](https\://github.com/itstrieu/itstrieu.github.io/blob/main/assets/img/motion\_controller\_skeleton.png?raw=true)

As the project grows, I’m realizing that I need systems not just for the robot—but for myself. I’ve added internal documentation, a structured to-do list by subsystem, and a `dev_notes.md` file that helps me track what I’m working on and why. This is on top of taking notes in my physical notebook. Writing things down keeps me sane when I feel like I’m drowning in tiny problems with no clear next step.

This robot is still a work in progress, but it already represents something bigger to me. It’s not just a machine I’m building—it’s a way for me to prove to myself that I can handle complexity, learn what I don’t know, and keep going even when I feel lost or overwhelmed. 
