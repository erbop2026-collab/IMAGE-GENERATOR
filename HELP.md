# Portion Calc — User Guide

Portion Calc helps catering kitchens turn cooked-portion plans into raw shopping lists, prep instructions, and cost breakdowns.

## Tabs

- **📊 Calculate** — build the order and see results.
- **⚙️ Products** — set up your ingredient catalog and run reverse calculations.
- **❓ Help** — this page (also available inside the app).

## Setting up products

Each product has a **Basic** sub-tab and a **Pricing & Labor** sub-tab.

### Basic

- **Name** — what you call the ingredient (e.g. "White rice").
- **Unit** — `oz`, `lb`, `cup`, `floz`, `qt`, `gal`, or `ct` (count). All math is done in this unit.
- **Raw amount** and **Cooked amount** — the conversion ratio for this product.
  Example: `12 oz raw → 36 oz cooked` means 1 oz raw yields 3 oz cooked.

### Pricing & Labor (all optional)

| Field | What it does |
|---|---|
| **Pack size** | Bag/sack size, e.g. 25 lb. Results round up to whole packs. |
| **Pot / Tray sizes** | List your pots with optional names (`small`, `large`). The app uses largest first; overflow goes into smallest. Total pot count drives cooking labor. |
| **Ingredient cost** | Value plus a basis: per measurement unit, per pack, or per piece. |
| **Packaging cost** | $ per single portion (e.g. takeout box). |
| **🍳 Cooking labor** | Time to cook ONE pot/tray, plus workers and $/hour. Total cost = pots × hours × workers × rate. |
| **📦 Packaging labor** | Separate from cooking. Choose basis: per portion / per carton of N portions / per cooking batch. |

## Building an order

On the **Calculate** tab:

1. **Order Details** — name and event date. Both stamp into history snapshots.
2. **Find / Quick-add** — type a product name. Matching chips appear; tap to add. The same search filters dropdowns inside existing rows. Tapping a chip for a product already in the order adds another size to the same group instead of duplicating.
3. **Cooking Order** — each row is one product. Inside a row you can add multiple sizes ("+ Add another size"). Reorder rows with ▲▼; duplicate a whole group with 📋.
4. **Calculate** — generates the results card and stores a snapshot in History.

## Reading the results

For each product:

- Total raw + total cooked + portion count.
- Pack rounding ("3 packs of 25 lb").
- Pot plan ("2 × large (10 oz) + 1 × small (5 oz)").
- Ingredient / Packaging / Cook labor / Pack labor breakdown.
- Subtotal per product.

A **Cost per single portion** section answers *"how much does ONE 8 oz vs ONE 12 oz portion cost?"* using the effective $/cooked-unit so pack-mode rounding flows through correctly.

Below that: total order cost and average per portion.

## Recipes (composite dishes)

A recipe is one meal made of several products. Example: *Chicken & Rice = 200 oz rice + 150 oz chicken + 50 oz sauce*. Define recipes in the **🍲 Recipes** tab.

In the order, tap **+ Add Recipe** (or quick-add via search) and enter the number of meals. The app expands each recipe into raw amounts of every component product, summed into the regular product totals — so the kitchen sees one consolidated shopping list and prep plan.

Recipes are **flat**: each component is a basic product, not another recipe. Nesting (recipe-within-recipe) is intentionally not supported in this version.

## Reverse calculation

On the **Products** tab: pick a product, enter the raw amount you have plus a portion size — the app tells you how many portions you can serve.

## Sharing the order

In the **Export & Backup** card on the Calculate tab:

| Button | What you get |
|---|---|
| 🍳 **For Kitchen** | Plain-text prep sheet — raw amounts, pack/pot counts, portion list. **No prices anywhere.** |
| 💼 **For Office** | Plain text with full cost breakdown plus per-portion price. |
| 💾 **JSON backup** | Full state snapshot — products, order, history, meta — machine-readable for restore. |
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
