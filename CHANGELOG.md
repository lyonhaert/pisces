# UNRELEASED
- Simple "Deck shuffled!" notification when you shuffle, plus messages for various other actions (mostly when you use hotkeys). These are also drawn to camera mirror so opponents can see you shuffled or which zone cards were moved to.
- Simple deck and hand counts in lower left of background (not mirrored to virtual cam -- if your opponents want to know, they can ask).
- Update Note can now set the note to multiple cards if you've selected more than one. Since the Note modal starts off with the current note of the card you right-click, you can also use this to 'copy' the note to other selected cards. *Example, select a card that has a note along with other cards that you want that note on -> right-click the first one that has the note -> click Ok on the modal -> now they all have 'Token Copy' note.*
- Improved input handling for Scryfall search screen so that one can do most earch parameters. For example, "is:token t:dragon power=5".
- Counter display sticks to the lower-left corner (display-wise) of a card, even when tapped.
- Default counters on a card have a label "+1/+1" if it's a creature card, "Loyalty" if it's a planeswalker card, and just generic "counters" for anything else. Simple, but a little awkward for the several frontface-creatue-backface-walker cards out there.
- There's now feedback in the top left of the background when using numeric keys prior to keybinds that use a numeric factor such as Draw (`D`), Mill (`M`), Scry (`R`), `+` or `-` for counters, and cloning with `Z`). Also clears out numeric input after 2 seconds of not hitting any others keys, to prevent you from doing what I did once, which was to hit `4`, open up my graveyard panel because I needed to look at something, but then I hit `4` again and then `M` for Mill. And I milled 44 cards instead of 4.
- You can also tuck a single card Nth from the top of the deck by using numeric input before using a Move to Top of Deck action (`J`). So `2` then `J` will put it second from the top. If Pisces thinks you're trying to act on more than one card you'll get an error message instead.
- A bunch of actions that operated on multiple selected/hovered cards with keybinds (like `T` for Tap) but only worked on a single card from the right-click menu... now operate on selected/hovered cards from the card right-click menu. Because now they run the same functions. Kindof.
- So that thing before where you can hold `Shift` when putting a face-down card into Exile via dragging or `E` and it'll stay facedown and hidden to the camera mirror (when flipping to peek at it)? Now you don't have to hold `Shift` **if** it started from your Hand and goes right to Exile (flipping with `F` and then `E` to exile, or flip and then dragging, or even using `F` to flip it while dragging).
- Creating tokens from a card's Tokens menu or duplicating cards will have them flagged as TOKEN on it. You can toggle an object's tokenality through the card right-click menu or `B`. By default when these go anywhere other than the battlefield they'll cease to exist, though there is a per-session "Tokens exist in zones" toggle in Options if you need an exception.
- Upgraded to latest GameMaker project version/runtime stuff and had to fix a couple things because of that.
- Fixed a minor bug with numeric factor entry that could cause repeats of the last number from a non-numeric keypress.
- Clear Objects button in Options to remove all cards, making it easier to load in a different deck.
- Errors from Scryfall will try to be written to `errors_scryfall.txt`, which will be located where `settings.ini` and card image caching is, in `%USERPROFILE%\AppDate\Local\Streamable\`. (this may change from Streamable to something else in the future)

---
# 2023-02-03
- **The F-key shortcuts have been changed to allow F1 to open a help screen in the future.** So now `F2` for Deck, `F3` for Graveyard, `F4` for Exile, and `F5` for Command Zone.
- Added upside-down flip with `Shift`+`F`. (No right-click menu entry yet)
- Fixed a bug where only the keyboard top row numbers could be used to preceed `D`, `M`, or `R` keybinds with an amount of cards to Draw, Mill, or Scry. Now the numpad numbers work, too. (Also the add/remove counters keybinds, below)
- Fixed issue where using `E` (exile), `C` (command zone), or `K` (bottom of deck) on a card that was already in the that zone caused an error and crash.
- Refactored counter add/remove keybinds &ndash; the `Numpad +` and `Numpad -` keys, minus/underscore key, and equal/plus key (but you don't have to hold shift) &ndash; to use the repeatable event like Draw, Mill, and Scry do so you can preceed it with numbers to add that many counters. Example: type `1`, `2`, and then `+` to add counters, and it'll add 12 counters.
- Allow Flip (front/back) of cards that are selected, not just the card that's hovered. In case of werewolves... or Ixidron.
- Holding `Ctrl` before starting the rubber-band selection will add cards to the current selection instead of starting over.
- `Ctrl` + left click on a card adds it to the current selection.
- Adjusted `gesture_drag_time` and `gesture_double_tap_time` so that double-tapping a card on the battlefield successfully toggles whether it's tapped or untapped.
- Added options for auto-deselect after tapping cards, and auto-deselecting after dragging and dropping them.
- Added simple ini settings that save the two auto-deselect options and the "Draw a card when starting a new turn" option (the `N` key that untaps everything - doesn't actually track turns).
- The camera mirroring button in Options now tells you if clicking it will turn it on or off.
- Save State should now track some other card attributes like flipped, upside-down, tapped, number of counters, and annotation.
- These are still rudimentary, but normal use of `Q` to coalesce arranges them diagonally - what's new is holding `Shift` to arrange them vertically or holding `Ctrl` to arrange them horizontally. It will still cycle top card to the back.
- Mostly, when cards are moved off the battlefield to one of the other zones, their statuses for being face-down or upside-down are reset to upright and front-face showing, and all cards in Graveyard and Exile are visible to Camera Mirroring (Hand and Deck being entirely hidden to the camera). There is now an exception for this if you hold `Shift` when exiling a face-down card with `E` or if you are holding `Shift` when you drop a face-down card into the Exile stack. That card becomes hidden to the Camera Mirroring and flipping it face-up in Exile will allow you to see it without opponents seeing it, so that you can exile cards face-down somewhat properly. Hovering that card in Exile and using `E` or doing a brief drag of the card and dropping it into Exile again _without_ holding `Shift` will reset it to face-up and be visible to opponents.

---
# 2022-12-17
- Fixed bugs with loading bad background/sleeve images causing a crash.
- Added an error window for when loading a background or sleeve image fails.
- Fixed bugs where cards put into the graveyard with Mill (`M` keybind) or from modifying `Esc` in the Scry view would put them at the bottom instead of the top.
- Fixed a bug where dragging card(s) to a hidden zone (Deck or Hand) was not clearing the counters.
- Added keybind hints to context menus.
- Some other misc. bugfixes.