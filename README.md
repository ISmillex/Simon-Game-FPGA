# Simon Game FPGA (Verilog) - Basys3

https://github.com/ISmillex/Simon-Game-FPGA/assets/72645646/149427c0-bcfc-4c9d-b239-14715d8ac0c0

This repository contains the Verilog code for implementing the classic Simon Game on the Basys3 FPGA development board. The Simon Game is a memory game that tests and improves your memory and cognitive skills. The game involves a sequence of lights that the player needs to remember and replicate.

## Table of Contents

- [Introduction](#introduction)
- [Features](#features)
- [Requirements](#requirements)
- [How the Program Works](#how-the-program-works)
- [Team Members](#team-members)
- [Usage](#usage)
- [Contributions](#contributions)
- [License](#license)

## Introduction

The Simon Game FPGA project aims to recreate the popular Simon Game on the Basys3 FPGA development board. The game uses buttons for player input, LEDs for displaying the sequence, and 7-segment displays for displaying the player's score and other game information.

## Features

- Generates a random sequence of lights and sounds that players need to memorize.
- Utilizes LEDs to display the sequence.
- Uses buttons for player input to replicate the sequence.
- Displays the player's score and game information on 7-segment displays.

## Requirements

To run and modify this project, you need the following:

- Basys3 FPGA development board.
- FPGA programming tools compatible with Basys3 (such as Xilinx Vivado).

## How the Program Works

The Simon Game implemented in this project follows a sequence of steps to provide an interactive gaming experience. Here's a high-level overview of how the program works:

1. **Initialization**: The game starts in an initialization state. When the player presses the "Start" button, the game transitions to the "Random On" state.

2. **Random Sequence Generation**: In the "Random On" state, the game generates a random sequence of LED lights and sounds that the player needs to memorize. The LEDs light up in a specific pattern, and the corresponding sound indicates the order of the sequence.

3. **Player Input**: After the random sequence is displayed, the game transitions to the "Input" state. The player's task is to replicate the sequence by pressing the buttons corresponding to the LEDs in the correct order.

4. **Checking Input**: Once the player has entered their sequence, the game transitions to the "Check" state. The program compares the player's input with the generated sequence to determine if it matches.

5. **Feedback and Scoring**: If the player's input matches the sequence, the game provides positive feedback through LED patterns and sound effects. The player's score increases, and the game transitions back to the "Random On" state to add another step to the sequence.

6. **Game Over**: If the player's input does not match the sequence, the game transitions to the "Game Over" state. The player's score is displayed on the 7-segment display, indicating the highest step reached in the sequence. The player can restart the game by pressing the "Start" button.

7. **Game Flow**: The game follows this sequence repeatedly, challenging the player's memory and reaction skills. As the player successfully replicates longer sequences, their score increases, reflecting their progress.

## Game Mechanics 

- The game uses the buttons for player input. Each button corresponds to a direction (up, down, left, right) that the player must match with the displayed LED sequence. 
- LED patterns and sounds provide visual and auditory cues to help players remember and reproduce the sequence. 
- The 7-segment displays show the player's score and highest step reached during the game. 
- The game transitions between different states using a state machine, ensuring a smooth flow of gameplay. 
- Button debouncing is applied to ensure reliable input from the player. 

## Team Members

This project was developed by a team of dedicated individuals who contributed their time and expertise to create the Simon Game FPGA implementation for the Basys3 board. We'd like to recognize the following team members for their valuable contributions:

- [Your Team Member's Name](https://github.com/teammember1)
- [Another Team Member's Name](https://github.com/teammember2)
- [Yet Another Team Member's Name](https://github.com/teammember3)

We appreciate the collaborative effort of our team members in making this project a success. Each member played a vital role in different aspects of the implementation, from coding and design to testing and documentation.

## Usage

1. Clone this repository to your local machine:

   ```bash
   git clone https://github.com/ISmillex/Simon-Game-FPGA.git
   ```

2. Open the project in your FPGA programming tool (e.g., Xilinx Vivado).

3. Compile and synthesize the Verilog code.

4. Program the compiled bitstream onto your Basys3 FPGA development board.

5. Interact with the game using the buttons to replicate the sequence.

6. The 7-segment displays will show your score and other game-related information.

## Contributions

Contributions to this project are welcome. If you find any issues or want to enhance the game, feel free to create pull requests or report issues in the repository.

When contributing, please follow best practices for code quality and readability.

## License

This project is licensed under the [MIT License](LICENSE). You are free to use, modify, and distribute the code as long as you include the original license file.
