# Portion Calc — User Guide

Portion Calc helps catering kitchens turn cooked-portion plans into raw shopping lists, prep instructions, and cost breakdowns.

## Two main concepts: ingredients vs. recipes

- **An ingredient** is a raw material with a raw → cooked conversion (rice, chicken, oil, eggs).
- **A recipe** is a composite dish — one meal made of several ingredients (e.g. *Chicken & Rice = 200 oz rice + 150 oz chicken + 50 oz sauce*).

You can put either an ingredient OR a recipe directly into an order. Recipes get expanded into their component ingredients automatically when you Calculate.

## Tabs

- **📊 Calculate** — build the order and see results.
- **⚙️ Ingredients** — set up your ingredient catalog and run reverse calculations.
- **🍲 Recipes** — define composite dishes (one meal = several ingredients).
- **❓ Help** — this page (also available inside the app).

## Setting up ingredients

Each ingredient has a **Basic** sub-tab and a **Pricing & Labor** sub-tab.

### Basic

- **Name** — what you call the ingredient (e.g. "White rice").
- **Unit** — `oz`, `lb`, `cup`, `floz`, `qt`, `gal`, or `ct` (count). All math is done in this unit.
- **Raw amount** and **Cooked amount** — the conversion ratio.
  Example: `12 oz raw → 36 oz cooked` means 1 oz raw yields 3 oz cooked.

### Pricing & Labor (all optional)

| Field | What it does |
|---|---|
| **Pack size** | Bag/sack size, e.g. 25 lb. Results round up to whole packs. |
| **Pot / Tray sizes** | List your pots with optional names (`small`, `large`). The app uses largest first; overflow goes into smallest. Total pot count drives cooking labor. |
| **Cost** | Value plus a basis: per measurement unit, per pack, or per piece. |
| **Packaging cost** | $ per single portion (e.g. takeout box). |
| **🍳 Cooking labor** | Time to cook ONE pot/tray, plus workers and $/hour. Total cost = pots × hours × workers × rate. |
| **📦 Packaging labor** | Separate from cooking. Choose basis: per portion / per carton of N portions / per cooking batch. |

## Recipes (composite dishes)

A recipe is one meal made of several ingredients. Define recipes in the **🍲 Recipes** tab — each component picks an ingredient from your catalog plus a per-meal amount.

In the order, tap **+ Add Recipe** (or quick-add via search) and enter the number of meals. The app expands each recipe into raw amounts of every component ingredient, summed into the regular ingredient totals — so the kitchen sees one consolidated shopping list and prep plan.

Recipes are **flat**: each component is a basic ingredient, not another recipe. Nesting (recipe-within-recipe) is intentionally not supported in this version.

## Building an order

On the **Calculate** tab:

1. **Order Details** — name and event date. Both stamp into history snapshots.
2. **Find / Quick-add** — type an ingredient or recipe name. Matching chips appear (recipes show with 🍲); tap to add. The same search filters dropdowns inside existing ingredient rows. Tapping a chip for an ingredient already in the order adds another size to the same group.
3. **Cooking Order** — each row is one ingredient (with one or more sizes) or one recipe (with a meal count). Reorder rows with ▲▼; duplicate a whole group with 📋.
4. **Calculate** — generates the results card and stores a snapshot in History.

## Reading the results

For each ingredient (including those expanded from recipes):

- Total raw + total cooked + portion count.
- Pack rounding ("3 packs of 25 lb").
- Pot plan ("2 × large (10 oz) + 1 × small (5 oz)").
- Ingredient / Packaging / Cook labor / Pack labor breakdown.
- Subtotal per ingredient.

A **Cost per single portion** section answers *"how much does ONE 8 oz vs ONE 12 oz portion cost?"* using the effective $/cooked-unit so pack-mode rounding flows through correctly.

Below that: total order cost and average per portion.

## Reverse calculation

On the **Ingredients** tab: pick an ingredient, enter the raw amount you have plus a portion size — the app tells you how many portions you can serve.

## Sharing the order

In the **Export & Backup** card on the Calculate tab:

| Button | What you get |
|---|---|
| 🍳 **For Kitchen** | Plain-text prep sheet — raw amounts, pack/pot counts, portion list. **No prices anywhere.** |
| 💼 **For Office** | Plain text with full cost breakdown plus per-portion price. |
| 💾 **JSON backup** | Full state snapshot — ingredients, recipes, order, history, meta — machine-readable for restore. |
| 📋 **Copy** | Copies the current export text to clipboard. |
| 📲 **Share** | Opens your phone's share sheet (WhatsApp, Mail, …). Falls back to a WhatsApp web link if not supported. |
| 💾 **Download** | Saves as a `.txt` (kitchen/office) or `.json` (backup) file. |
| 🖨 **Print / PDF** | Prints directly. From the print dialog you can choose **Save as PDF**. |
| 📥 **Import** | Paste JSON or pick a file. Replaces all data after a confirmation. |

## History

Every Calculate saves an entry with the order name, date, rows, and totals.

- Tap **↻ Load** to restore an entry into the editor.
- Tap 🗑 to delete a single entry.
- **Clear all** wipes the entire history.

## Data persistence

The app stores everything in the device's local storage. Your data **survives**:

- Closing and reopening the app.
- Restarting the phone.
- Updating the app over the previous build (signature must match).

Your data is **wiped** if you:

- Uninstall the app (Android removes its data partition).
- Clear app data from Android settings.
- Replace your phone.

**Best practice:** use 💾 **JSON backup** periodically and store the file in Drive / WhatsApp / email. The app will gently remind you with a toast if a week passes without a backup. Restore by pasting or picking the JSON in the Import field.
