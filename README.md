Internet Financial EXchange (IFEX) Protocol
===========================================

The Internet Financial Exchange (IFEX) protocol facilitates the 
description, negotiation and management of economic transactions.

The protocol utilizes, references and complements the following proposals:
 * [IIBAN](https://github.com/globalcitizen/iiban): internet international bank account numbers
 * [IMIC](https://github.com/globalcitizen/imic): internet market identification
 * [X-ISO4217-A3](https://github.com/globalcitizen/x-iso4217-a3): registry of unofficial ISO-compatible asset type codepoints

Status
------
In development.

Documentation
-------------
* __msc/__:
  Contains 'mscgen' (Message Sequence Chart Generator) source and
  illustrations with examples of proposed protocol flow.  mscgen
  is available from http://www.mcternan.me.uk/mscgen/

* __json-schema/__:
  Contains proposed JSON Schema for various message types/elements.
  These are also hosted at http://schema.ifex-project.org/. For
  more information on JSON Schema, see http://json-schema.org/

* __old/__:
  Prior documentation from initial development era ~2012.

Building
--------
To build, just type 'make'.

Alternatively, the latest version should be available as .txt at:
https://raw.github.com/globalcitizen/ifex-protocol/master/draft-ifex-00.txt
