use std::fs::File;
use std::io::{Read, Result};

fn main() -> Result<()>{
     let mut file = File::open("input.txt")?;

    let mut input = String::new();


    file.read_to_string(&mut input)?;

    let final_floor = calculate_floor(&input);
    println!("Santa ends up on floor: {}", final_floor);

    match find_first_basement_position(&input) {
        Some(position) => println!("First basement entry at position: {}", position),
        None => println!("Santa never enters the basement"),
    }

    Ok(())
}

// sol 1

fn calculate_floor(instructions: &str) -> i32 {
    instructions.chars().fold(0, |floor, c| {
        match c {
            '(' => floor + 1,
            ')' => floor - 1,
            _ => floor,
        }
    })
}

// sol 2

fn find_first_basement_position(instructions: &str) -> Option<usize> {
    let mut floor = 0;

    for (i, c) in instructions.chars().enumerate() {
        floor += match c {
            '(' => 1,
            ')' => -1,
            _ => 0,
        };

        // basement is below 0
        if floor == -1 {
            return Some(i + 1);
        }
    }

    None
}