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

## Bulk import from Excel / Google Sheets (CSV)

The Ingredients tab has a **📥 Bulk import (CSV)** card. Paste a CSV table or pick a `.csv` file. From Excel: **File → Save as → CSV**. Tap **📄 Load template** in the app to see a working sample.

**Required columns** (case-insensitive; spaces / underscores / dashes are ignored): `name`, `unit`, `raw`, `cooked`.

**Optional columns:**

| Column | Meaning |
|---|---|
| `packSize` | Bag/sack size in the ingredient's unit |
| `cost` | Numeric cost value |
| `costMode` | `measure` / `pack` / `piece` |
| `packagingCost` | $ per single portion |
| `potSizes` | One or more pots; semicolon-separated names with optional name, e.g. `small:5;large:10` or `5;10;20` |
| `laborHours`, `laborWorkers`, `laborRate` | Cooking labor (hours/pot, workers, $/h) |
| `packLaborHours`, `packLaborWorkers`, `packLaborRate` | Packaging labor |
| `packLaborBasis` | `portion` / `carton` / `batch` |
| `cartonSize` | Portions per carton (when basis = carton) |

Rows whose `name` matches an existing ingredient are **updated in place**; new names are added. After import you'll see a toast with `added / updated / skipped` counts; full per-row issues print to the browser console.

## Recipes (composite dishes)

A recipe is one meal made of several ingredients. Define recipes in the **🍲 Recipes** tab — each component picks an ingredient from your catalog plus a per-batch raw amount.

In the order, tap **+ Add Dish** in the Calculator and pick the recipe. The app expands the recipe into raw amounts of every component ingredient, summed into the totals.

Recipes are **flat**: each component is a basic ingredient, not another recipe. Nesting is intentionally not supported.

### Recipe form fields

| Field | What goes in |
|---|---|
| **Recipe name** | What you call the dish (e.g. "Kugel"). |
| **Yield mode** | **Cooked output (manual)** — you type the cooked yield directly (best for bake-driven recipes like kugel, brisket). **Derived from ⭐ lead RAW** — yield is auto-computed from `lead.amount × lead's cooked/raw ratio` (best for raw-anchored recipes like rice, pasta). |
| **Yield / batch (cooked)** | How much COOKED food one batch makes. The single anchor for all calculations. In derived mode this field is read-only. |
| **Yield unit** | `oz` / `lb` / `floz` / `cup` / `qt` / `gal` / `ct`. Changing the dropdown auto-converts the number within the same kind (lb↔oz, qt↔floz). |
| **Volume occupied (optional)** | The same batch but expressed by volume. Fill ONLY when you want packaging in a different unit kind (e.g. recipe in `lb`, packaging in `fl oz`). The volume side and weight side are coupled by *density*: editing one updates the other to preserve the implied density (water = 1.0). |
| **Density (small text)** | The implicit weight/volume ratio. `≈ water` is normal; `(airy)` or `⚠ unusually dense` flags fields that may not match physically. |
| **Or pick equipment** | A shortcut that auto-fills yield + volume from a pot/pan from the 🧰 Equipment catalog. **Informational only** — never affects calculation; you can still edit any value after picking. |
| **Reference (optional)** | Free-text note for yourself, e.g. *"1 Kugel = 1 pan 9×13"*. Not used in math. |
| **Components** | The ingredients inside one batch. Each row: ⭐ lead toggle, searchable ingredient picker (click → all ingredients alphabetical; type to filter), RAW amount per batch, unit (taken from the ingredient). |
| **Default packaging** | Multi-select of which packs from the 📦 Packaging catalog can wrap this dish. Only tagged packs appear in the Calculator's Packaging-size dropdown for orders of this dish. |

### Reverse Calc — How many portions?

Each recipe view card has a built-in Reverse Calc panel at the bottom. Pick one of three input modes:

- **N batches** — multiply the recipe's yield by N.
- **X cooked** — directly type how much cooked food you have.
- **R raw of ⭐ lead** — uses the lead ingredient's raw→cooked ratio.

Then pick a portion size (from the recipe's tagged packs) and you'll see how many portions plus leftover.

Cross-kind unit (lead in `lb`, recipe yield in `floz`) isn't supported — convert manually or fill **Volume occupied** so the bridge works.

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

## Equipment (pots, pans, kettles)

Set up cooking vessels in the **🧰 Equipment** tab. Each pot has shape (round/rect), inner dimensions, and an auto-derived volume in fl oz. You can override capacity in `lb` if the manufacturer's rated capacity differs from the geometric maximum.

Pots are pulled into recipes via the *Or pick equipment* shortcut and used by the Calculator's per-dish equipment plan (which size pot for which dish, how many of each).

## Packaging

The **📦 Packaging** tab is a catalog of single-use containers. Each pack has:

| Field | What goes in |
|---|---|
| **Name** | e.g. "Foil 21x13x3.5", "Deli 8 oz". |
| **Shape** | Rectangular or Round. |
| **Inner dimensions (optional)** | L/W/H for rect, D/H for round. Auto-derives a theoretical capacity. |
| **Capacity** | The manufacturer's usable capacity (often less than geometric — typically 70-80%). Editable after auto-derive. |
| **Unit** | `oz cooked`, `lb cooked`, `fl oz`, `cup`, `qt`, or `portions`. |
| **Box** | Units per case + case price → unit price auto-computed. |
| **Separate lid** (optional) | Tick if your supplier sells lids in a separate case. Lid case qty + case price are added on top. |

Auto-fill helpers: typing a name with `5 lb`, `12 fl oz`, etc. fills capacity. So do dimensions. Auto-fill only kicks in when capacity is empty — once typed manually, it never overrides.

## Reverse calculation

Each recipe card on the **🍲 Recipes** tab has a built-in *🔄 How many portions?* panel — see the Recipes section above.

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
