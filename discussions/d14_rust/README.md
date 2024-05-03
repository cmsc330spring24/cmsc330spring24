# Discussion 14 - Friday, May 3

## Reminders

- Project 7 due **Thursday, May 9th @ 11:59PM**
- Final Exam **Monday, May 13th @ 4-6PM**
  - Logistics & Room Assignments (based on last name): [@2074](https://piazza.com/class/lrf5qvp042i1y2/post/2074)
  - Final review session **next Wednesday, May 8th, 6-8:30PM @ Antonov**: [@2100](https://piazza.com/class/lrf5qvp042i1y2/post/2100)

## Exercises

### General Debugging

Each of the functions in [`error.rs`](https://play.rust-lang.org/?version=stable&mode=debug&edition=2021&gist=4e4c4ae42395098a2aefabbcae925c08) has an error. Find the errors and fix them.


### Traits, Enums, & Structures

Let's try to implement a simplified game of Pokemon: [`pokemon.rs`](https://play.rust-lang.org/?version=stable&mode=debug&edition=2021&gist=e9ca91e067b217a0179225b7cdb2670a)

Take a couple of minutes to read through the code and understand the different traits, enums, and structures being used.

#### Instantiate Pokemon

Let's start by creating some Pokemon to play with. Here are some examples:

```txt
Squirtle (Water):
- 50/50 HP, Level 5
- Moves:
  - Tackle (Normal),   does 10 damage
  - Water Gun (Water), does 15 damage

Charmander (Fire):
- 60/60 HP, Level 6
- Moves:
  - Scratch (Normal),  does 10 damage
  - Ember (Fire),      does 15 damage

Bulbasaur (Grass):
- 40/40 HP, Level 4
- Moves:
  - Tackle (Normal),   does 10 damage
  - Vine Whip (Grass), does 15 damage
```


<details>
  <summary>Rust code for creating all of the above:</summary>

  ```rust
  let mut charmander = PokemonCharacter {
      name: String::from("Charmander"),
      level: 6,
      hp: 60,
      max_hp: 60,
      pokemon_type: PokemonType::Fire,
      moves: vec![
          PokemonMove {
              name: String::from("Scratch"),
              move_type: PokemonType::Normal,
              damage: 10,
          },
          PokemonMove {
              name: String::from("Ember"),
              move_type: PokemonType::Fire,
              damage: 15,
          },
      ],
  };

  let mut squirtle = PokemonCharacter {
      name: String::from("Squirtle"),
      level: 5,
      hp: 50,
      max_hp: 50,
      pokemon_type: PokemonType::Water,
      moves: vec![
          PokemonMove {
              name: String::from("Tackle"),
              move_type: PokemonType::Normal,
              damage: 10,
          },
          PokemonMove {
              name: String::from("Water Gun"),
              move_type: PokemonType::Water,
              damage: 15,
          },
      ],
  };

  let mut bulbasaur = PokemonCharacter {
      name: String::from("Bulbasaur"),
      level: 4,
      hp: 40,
      max_hp: 40,
      pokemon_type: PokemonType::Grass,
      moves: vec![
          PokemonMove {
              name: String::from("Tackle"),
              move_type: PokemonType::Normal,
              damage: 10,
          },
          PokemonMove {
              name: String::from("Vine Whip"),
              move_type: PokemonType::Grass,
              damage: 15,
          },
      ],
  };
  ```
</details>

#### Summary

I want to implement a `Summary` trait for my Pokemon so I can see their current health & level. I should be able to call it like so:

```rust
println!("{}", squirtle.summary());
println!("{}", charmander.summary());
```

<details>
  <summary>Example output:</summary>

  ```bash
  [Squirtle]: 93/100 HP, Level 10
  [Charmander]: 50/50 HP, Level 5
  ```
</details>

<br>

We can reimplement the same `Summary` trait for the moves to get a similar summary of their types and power:

```rust
for m in &charmander.moves {
    println!("{}", m.summary());
}

println!();

for m in &squirtle.moves {
    println!("{}", m.summary());
}
```

<details>
  <summary>Example output:</summary>

  ```bash
  [Scratch]: Type Normal, Power 10
  [Ember]: Type Fire, Power 15

  [Tackle]: Type Normal, Power 10
  [Water Gun]: Type Water, Power 15
  ```
</details>


#### Battle

Let's simulate a basic pokemon battle. Here's an example battle:

```rust
println!("{}", charmander.summary());
println!("{}", squirtle.summary());
println!();

charmander.attack(&mut squirtle);
squirtle.attack(&mut charmander);
println!();

println!("{}", charmander.summary());
println!("{}", squirtle.summary());
println!();

println!("Leveling up Squirtle, healing charmander...");
println!();

squirtle.level_up();
charmander.heal();

println!("{}", charmander.summary());
println!("{}", squirtle.summary());
println!();
```

<details>
  <summary>Example output:</summary>

  ```txt
  [Charmander]: 60/60 HP, Level 6
  [Squirtle]: 50/50 HP, Level 5

  Charmander used Scratch!
  Squirtle took 10 damage!
  Squirtle used Water Gun!
  It's super effective!
  Charmander took 30 damage!

  [Charmander]: 30/60 HP, Level 6
  [Squirtle]: 40/50 HP, Level 5

  Leveling up Squirtle, healing charmander...

  [Charmander]: 60/60 HP, Level 6
  [Squirtle]: 60/60 HP, Level 6
  ```

</details>

### Solutions
Solutions are in [`SOLUTIONS.md`](./SOLUTIONS.md).

## Resources

- [Spring23 Discussion 11 - Rust](https://github.com/cmsc330-umd/spring23/tree/main/discussions/d11_rust)
- [Rust Playground](https://play.rust-lang.org/)
- [Rust Book](https://doc.rust-lang.org/book/)
- [Rust Book - Defining and Instantiating Structs](https://doc.rust-lang.org/book/ch05-01-defining-structs.html)
- [Rust Book - Defining an Enum](https://doc.rust-lang.org/book/ch06-01-defining-an-enum.html)
- [Rust Book - Traits](https://doc.rust-lang.org/book/ch10-02-traits.html)
