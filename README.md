# ASM-Test
Using this repo to learn my way around (x86 ftw) assembly, specifically in Systems Engineering.

# Progress & Learning
Latest progress: Abstraction of functions, print is now a seperate file!<br>
Latest thing I learned: "\n" is actually 2 characters, the Newline and the Carriage Return.<br>
Previous milestones:
- Abstraction of functions, print is now a seperate file! (Hey! That's this milestone!)
- Bootloader that prints Hello, World!
- Bootloader that boots into Text mode!

# Abandon Hope All Ye Who Enter Here
Assembly, especially for operating systems and systems eng. usually is looked down upon for beginners.<br>
But alas, I, a beginner in ASM, am taking on this boring but fulfilling challenge. (emphasis on challenge!)<br>
I think that setting a big, **big** project to complete over many months/years is a great idea, as long as you have other similar projects to bounce off of, so why not learn how to make an operating system at the same time as I learn how to program in ASM? I don't plan on becoming the next Linus Torvalds, but I do plan on learning a lot of assembly from this.

# Software I'm using
I'm using [NASM][nasm] to compile my assembly code.<br>
I'm using [QEMU][qemu] to run/emulate my code.

# Building & Running
To build and run these programs, Make sure you have [NASM][nasm] and [QEMU][qemu] installed.<br>
Then, you need to clone this repo, and run this command to build:<br>
`nasm -f bin -o boot.bin boot.asm`<br>
Then, to run the bootloader in qemu, run:<br>
`qemu-system-x86_64 boot.bin`<br>
And off to the races you go! (other than changing boot to your desired file name, of course)

# Resources to bounce off of when I get stuck
To learn ASM, I found [a tutorial playlist on YouTube][yt], 
and [The first link on google][firstlink].<br>
I have been using [OSDev][osdev] 
and [This Russian site I found on Google][russiansite]
and a lot of [Wikipedia][wikipedia].<br>
Another resource is [This book][goodbook] 
and [This git repo that has short step-by-step instructions][nicegit].
Found another nice interrupt list [here][anotherinterrupt]. 

# One more note
You should never, ***ever*** copy and paste code from anywhere, these resources are just to help you write your implementation. You should be writing your own code, even if it's uncanny how similar it is to these guides. You'll learn a lot from these guides, but you'll learn even more from experimenting and playing around with it!<br>
Also safety blah blah blah never copy code unsafe blah blah blah

# License
This repo, just like most of my other repos, is licensed under the [GPL License](LICENSE).

[yt]: https://www.youtube.com/playlist?list=PLetF-YjXm-sCH6FrTz4AQhfH6INDQvQSn
[firstlink]: https://www.tutorialspoint.com/assembly_programming/
[osdev]: https://wiki.osdev.org/
[russiansite]: http://vitaly_filatov.tripod.com/ng/asm/
[wikipedia]: https://en.wikipedia.org/wiki/BIOS_interrupt_call
[goodbook]: https://www.cs.bham.ac.uk//~exr/lectures/opsys/10_11/lectures/os-dev.pdf
[nicegit]: https://github.com/cfenollosa/os-tutorial/
[anotherinterrupt]: https://stanislavs.org/helppc/idx_interrupt.html
[nasm]: https://www.nasm.us/
[qemu]: https://www.qemu.org/