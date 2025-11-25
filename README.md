# Library Fine Processing System (PL/SQL)

## Overview
This project demonstrates the use of:
- PL/SQL **Collections**
- PL/SQL **Records**
- **GOTO** statements for skipping invalid data

The scenario simulates processing overdue library fines.

## Features
- Uses a **RECORD** type to store fine data
- Uses a **Nested Table Collection** to store multiple overdue cases
- Uses **GOTO** to handle invalid data entries
- Prints fine results for valid records

## Files
- `process_fines.sql` – Main PL/SQL script.

## How to Run
1. Open SQL*Plus or Oracle SQL Developer
2. Run:

```sql
@process_fines.sql
