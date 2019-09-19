# SDF

A SDF stream is a little-endian binary stream of instructions which describe a
signed distance field.

There are four primitive types:

| ID | Name     | Description                     |
| -- | -------- | ------------------------------- |
| 0  | Void     | No value.                       |
| 1  | Boolean  | True or false.                  |
| 2  | Number   | Decimal of undefined precision. |
| 3  | Reserved | Currently unused.               |

An opcode is a 16-bit unsigned integer.

| Start Bit | End Bit | Description                                            |
| --------- | ------- | ------------------------------------------------------ |
| 0         | 1       | Result primitive type.                                 |
| 2         | 3       | Argument A primitive type.                             |
| 4         | 5       | Argument B primitive type.                             |
| 6         | 7       | Argument C primitive type.                             |
| 8         | 15      | Opcode ID.                                             |

| Opcode | Result  | A       | B       | C       | ID | Description             | Undefined Behavior |
| ------ | ------- | ------- | ------- | ------- | -- | ----------------------- | ------------------ |
| 5000   | Boolean | Boolean | Void    | Void    | 00 | Not                     |                    |
| 5400   | Boolean | Boolean | Boolean | Void    | 00 | And                     |                    |
| 5401   | Boolean | Boolean | Boolean | Void    | 01 | Or                      |                    |
| 5402   | Boolean | Boolean | Boolean | Void    | 02 | Equal                   |                    |
| 5403   | Boolean | Boolean | Boolean | Void    | 03 | Not Equal               |                    |
| 5500   | Boolean | Boolean | Boolean | Boolean | 00 | Conditional (A ? B : C) |                    |
| 5A00   | Boolean | Boolean | Number  | Number  | 00 | Conditional (A ? B : C) |                    |
| 6800   | Boolean | Number  | Number  | Void    | 00 | Greater Than            | A = B              |
| 8000   | Number  | Void    | Void    | Void    | ** | Parameter               |                    |
| A000   | Number  | Number  | Void    | Void    | 00 | Negate                  |                    |
| A001   | Number  | Number  | Void    | Void    | 01 | Sine                    |                    |
| A002   | Number  | Number  | Void    | Void    | 02 | Cosine                  |                    |
| A003   | Number  | Number  | Void    | Void    | 03 | Tangent                 |                    |
| A004   | Number  | Number  | Void    | Void    | 04 | Arc Sine                |                    |
| A005   | Number  | Number  | Void    | Void    | 05 | Arc Cosine              |                    |
| A006   | Number  | Number  | Void    | Void    | 06 | Arc Tangent             |                    |
| A007   | Number  | Number  | Void    | Void    | 07 | Hyperbolic Sine         |                    |
| A008   | Number  | Number  | Void    | Void    | 08 | Hyperbolic Cosine       |                    |
| A009   | Number  | Number  | Void    | Void    | 09 | Hyperbolic Tangent      |                    |
| A00A   | Number  | Number  | Void    | Void    | 0A | Hyperbolic Arc Sine     |                    |
| A00B   | Number  | Number  | Void    | Void    | 0B | Hyperbolic Arc Cosine   |                    |
| A00C   | Number  | Number  | Void    | Void    | 0C | Hyperbolic Arc Tangent  |                    |
| A00D   | Number  | Number  | Void    | Void    | 0D | Absolute                |                    |
| A00E   | Number  | Number  | Void    | Void    | 0E | Square Root             |                    |
| A00F   | Number  | Number  | Void    | Void    | 0F | Floor                   |                    |
| A010   | Number  | Number  | Void    | Void    | 10 | Ceiling                 |                    |
| A011   | Number  | Number  | Void    | Void    | 11 | Natural Logarithm       |                    |
| A012   | Number  | Number  | Void    | Void    | 12 | Logarithm 10            |                    |
| A013   | Number  | Number  | Void    | Void    | 13 | Natural Power           |                    |
| A800   | Number  | Number  | Number  | Void    | 00 | Add                     |                    |
| A801   | Number  | Number  | Number  | Void    | 01 | Subtract                |                    |
| A802   | Number  | Number  | Number  | Void    | 02 | Multiply                |                    |
| A803   | Number  | Number  | Number  | Void    | 03 | Divide                  | B = 0              |
| A804   | Number  | Number  | Number  | Void    | 04 | Pow                     | A < 0              |
| A805   | Number  | Number  | Number  | Void    | 05 | Modulo                  |                    |
| A806   | Number  | Number  | Number  | Void    | 06 | Arc Tangent             |                    |

Each instruction is its opcode, followed by a u16 for each of its arguments in
order.

An argument is the index of the result of a previous instruction.  It is an
error to use the result of the instruction for which arguments are being
specified, one which will be defined later in the stream, or one which never
will.

It is also an error to use an argument of a primitive type which does not match
that of the parameter it is providing a value for.

The result of the last instruction in the stream is taken to be the distance to
the nearest surface.  It is an error to have the last instruction in the stream
return any type but number.

An empty stream is considered to be a constant of infinity.
