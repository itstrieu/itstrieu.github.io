---
title: Fluent Python and Special Methods
date: 2025-02-22
layout: post
tags:
    - Python
description: An overview of my plan to improve Python skills along with a writeup for a Python exercise on special methods. 
image: python_special_method.jpg
---

# Saturday, February 22, 2025

Failing the Python portion of my technical interviews in December was both embarrassing and disappointing. However, it turned out to be an invaluable first technical interview experience. The interviewers were all incredibly talented and kind, and I walked away with a clear understanding of where to focus my efforts—an important win.

Out of four interviews, one focused on traditional data structures and algorithms (DSA), while another was a pure Python assessment. I could have performed significantly better in both had I done one crucial thing: **practice**.

I’m not sure how common it is to absorb a lot of knowledge through reading and watching videos and assume that’s enough, but that’s exactly what I did. I spent two weeks cramming as much as I could about DSA and Python programming. I completed numerous Leetcode problems, but not nearly enough to truly internalize the patterns and implementation strategies. Instead of reinforcing what I learned through repetition and testing myself, I continuously sought out new concepts. This was my biggest mistake—I should not have considered myself prepared until I had thoroughly tested my ability to apply what I learned.

This time around, I’m taking a different approach—learning at a slower pace. Not having an immediate deadline is helpful. Since my preferred way of absorbing knowledge is through reading (followed by watching videos), I decided to read [_Fluent Python_](https://www.oreilly.com/library/view/fluent-python-2nd/9781492056348/) by [Luciano Ramalho](https://www.oreilly.com/search?q=author:%22Luciano%20Ramalho%22) in its entirety while re-evaluating my Leetcode strategy. Unlike before, I’m prioritizing hands-on practice and assessment, making them just as—if not more—important than passive learning. Additionally, I’ve introduced a structured review process. Initially unsure of the best approach, I’ve settled on writing about the exercises I complete, incorporating teaching as part of my learning workflow.

### Study Plan:

> **Read Fluent Python Chapters → Complete Exercises → Review/Teach**

So far, I’ve completed Chapters 1, 2, 3, and 5 of _Fluent Python_. After finishing Chapter 3, I asked ChatGPT to generate exercises:

> "I want to work on exercises to reinforce what I learned from _Fluent Python_, Chapters 1–3. Give me short exercises/assignments."

Chapter 1 covers _The Python Data Model_, Chapter 2 covers _An Array of Sequences_, and Chapter 3 covers _Dictionaries and Sets_.

Here’s one of the exercises along with my solution:

### **Exercise 1: Understanding `__repr__` and `__str__`**

Write a class called `Card` representing a playing card with a rank (e.g., 'Ace', '2', '3', ...) and a suit (e.g., 'Hearts', 'Clubs'). Implement the `__repr__` and `__str__` methods so that:

- `__repr__` returns a formal representation: `Card('Ace', 'Hearts')`.
- `__str__` returns a user-friendly representation: `'Ace of Hearts'`.

#### **Learning Objective:**

Understanding the difference between `__repr__` and `__str__`.

```python
class Card:
    def __init__(self, suit='Spades', rank='Ace'):
        self.suit = suit
        self.rank = rank
    
    def __repr__(self):
        return f"Card('{self.rank}', '{self.suit}')"
    
    def __str__(self):
        return f"{self.rank} of {self.suit}"
    
    def __iter__(self):
        return iter((self.rank, self.suit))

# Example usage:
card = Card('Hearts', 'Four')
print(card)  # Four of Hearts
print(repr(card))  # Card('Four', 'Hearts')

suits = ['Spades', 'Clubs', 'Hearts', 'Diamonds']
ranks = ['Two', 'Three', 'Four', 'Five', 'Six', 'Seven', 'Eight', 'Nine', 'Ten', 'Jack', 'Queen', 'King', 'Ace']
deck = [Card(suit, rank) for suit in suits for rank in ranks]

print(deck[:10])
print([str(card) for card in deck[:10]])
```

#### **Expected Output:**

```
Four of Hearts
Card('Four', 'Hearts')
[Card('Two', 'Spades'), Card('Three', 'Spades'), Card('Four', 'Spades'), Card('Five', 'Spades'), Card('Six', 'Spades'), Card('Seven', 'Spades'), Card('Eight', 'Spades'), Card('Nine', 'Spades'), Card('Ten', 'Spades'), Card('Jack', 'Spades')]
['Two of Spades', 'Three of Spades', 'Four of Spades', 'Five of Spades', 'Six of Spades', 'Seven of Spades', 'Eight of Spades', 'Nine of Spades', 'Ten of Spades', 'Jack of Spades']
```

This was an excellent starting exercise because, right away, I had to write a class—something I struggled with during my interview.

The exercise directly reinforces the main concept of Chapter 1: Python’s special methods. These methods are enclosed with double underscores (e.g., `__repr__`, `__str__`). As someone who initially learned Python for data analysis and machine learning, I had only encountered `__init__`, so I hadn’t realized how fundamental special methods are for object-oriented programming. These methods aren't meant to be called directly by users but instead define how objects behave when used with built-in Python functions. For example, `__len__` allows an object to return its length when passed to `len(obj)`, rather than requiring `obj.__len__()`.

So, what’s the difference between `__repr__` and `__str__`?

- **`__repr__`** provides an unambiguous string representation of an object, ideally one that could be used to recreate the object. Without it, printing an object would return a default type reference instead. According to _Fluent Python_, `__repr__` should "be unambiguous and, if possible, match the source code necessary to re-create the represented object."[^1] In my implementation, `repr(card)` returns `Card('Four', 'Hearts')`, which satisfies this requirement.
    
- **`__str__`** returns a human-readable, user-friendly string representation of an object. In my implementation, `str(card)` returns `"Four of Hearts"`.
    

I also included `__iter__` in my class because I planned to reuse it for later exercises. 

ChatGPT provided me with six exercises, which you can find [here](https://github.com/itstrieu/fluent-python-notes/blob/main/1_3_exercises.ipynb) on my GitHub. While I’ve completed them, I haven’t written up my reflections yet. I’ll be posting more as I review my solutions and continue my reading.