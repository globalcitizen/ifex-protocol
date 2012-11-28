.\"
.\" The IFEX Protocol
.\"  http://ifex-project.org/
.\"
.so tmac.id
.tl 'INTERNET-DRAFT''Walter Stanish'
.tl 'Intended status: Standards Track''Payward Inc.'
.tl 'Category: Experimental''\*(MO \n[*xyear]'
.tl 'Expires: \*[*XP]'''
.LP
.ce 2
Internet Financial Exchange Protocol (IFEX) 
draft-ifex-00

.LP
.B Abstract
.LP
.in 3

The Internet Financial Exchange (IFEX) protocol facilitates 
the negotiation of financial transactions between internet-based
financial endpoints.

.IDBOILER "i"

.COPYSTATEMENT

.LP
.KS

.LP
.MH 1 Introduction
.LP
.in 3

The Internet Financial Exchange (IFEX) protocol facilitates
the negotiation of financial transactions between internet-based
financial endpoints.

Minimal assumptions are made regarding asset type,
settlement network, pre-existing trust relationships, 
communications topology, or security encapsulation.

IFEX is a message oriented, transport neutral, state based protocol.

IFEX supports the traditional request/response model as well as n:n
anycast/broadcast/multicast.

IFEX provides a building block with which the internet community can
develop viable, high performance, low latency, highly available,
flexible topology alternatives to legacy financial systems.

.RFC2119

.KE
.LP
.bp
.TOCP
.bp

.LP
.MH 1 Preface
.LP
.MH 2 Terminology
.LP
.in 3

.MH 3 "Financial Transaction"
.in 3

The term 'financial transaction' is adopted here to refer to the abstract
notion of any change in the possession of some asset (ie. some currency
or commodity) between two or more parties.  This definition is intentionally
broad in order to include as many present or future systems of exchange 
as possible.

.MH 3 "Message"
.in 3

A complete set of information sent between two entities across a computer
system or network, ie. ignoring any intermediate segmentation for the 
purposes of transfer across a given logical or physical transport.
.
.MH 3 "Transaction"
.in 3

The term 'transaction' is used to refer to the interchange of information 
between two or more parties over a computer networking protocol (such as
IFEX), typically consisting of a request and a response.  While the IFEX 
protocol facilitates transactions, it is not limited to this model and
can also be used for event notification or information dissemination,
since this is a required feature for some segments of the financial 
systems sector (notably market information broadcast).

.bp
.LP
.MH 1 Requirement
.LP

.MH 2 "Primary Functionality"
.in 3

Certain functionality required by modern financial 
systems is not presently available in open, legacy-free,
adequately globalized protocols.

This functionality includes:

 * Settlement and reversal / cancellation term negotiation

 * Exchange rate negotiation

 * Latency calculation / negotiation

 * Fee, tax and discount calculation / negotiation

 * Arbitrary currency / asset support

 * Multi-currency / asset transaction support

 * Quotation support

 * Multiple settlement path support
 
 * Optional support for in-band settlement (sometimes known as DVP,
   or 'delivery versus payment')

 * High precision decimal value support

 * Arbitrary financial settlement topology support

 * Arbitrary communications topology support

Given this situation, it makes sense to propose a legacy-free,
adequately extensible protocol for internet-based financial exchange.

.bp
.LP
.MH 2 "Related Functionality"
.LP
.in 3

Research in to existing protocols and their ecosystems highlighted
the fact that various related functionality sometimes occurs alongside
financial transaction negotiation processes.

Such functionality includes:

 * Transaction description/notification (as opposed to negotiation)

 * Notifications and messaging variously regarding financial assets,
   transaction status, financial parties and systems.

   Classic examples include corporate action announcements sent to
   markets, stock split or shareholder meeting notifications, and
   market-wide or instrument-linked trade suspension and resumption.

   (Certain situations such as dividend cash payout/re-investment
   preferencing may require two way messaging and as such exceed
   a pure 'notification' notion.)

 * Shareholder transparency inquiry procedures in which a series
   of tiered requests and responses regarding asset ownership
   information may be triggered by a market authority.

The approach taken in the design of IFEX has been to increase the
descriptiveness of the base protocol to reduce the number of
such edge cases handled within the base protocol wherever possible.
(For instance, market availability may be described as part of the
temporal parameters of a financial settlement path.)  Further
requirements SHOULD be possible to implement as extensions to the
base IFEX protocol as they emerge in the future.

.bp
.LP
.MH 2 "Use Cases"
.LP
.in 3

Use cases might include the following:

 * Internet transactions between parties with no prior 
   relationship, where identities and credit are potentially 
   based directly upon participation-driven, agovernmental 
   community mandate and irrespective of physical legal 
   jurisdiction(s).  (For example via digital currencies
   with distributed state such as [BITCOIN], or via 
   mutual credit systems such as [TEMS], [CES] or [RIPPLE])

 * The owner of market-consolidated assets such as corporate
   stocks negotiating their sale on a market or off-market
   alternate trading system (ATS) or electronic communications
   system (ECS), possibly via one or more brokers.

 * Notification to various bank systems of the physical deposit 
   of various denominations of a conventional currency at an 
   automatic teller machine (ATM) against an existing account.

 * A direct debit instruction sent from a merchant to a 
   particular customer's bank, including reference authorization
   information, possibly via a payment processor, describing an 
   amount to be debited from the customer and credited the 
   merchant or a third party.

 * A consumer to bank/broker request for the purchase of one
   conventional currency asset with another (foreign exchange 
   service).  In addition, prerequisite quotation services.

 * Consumer to bank/broker request for quotation on the 
   delivery of assets to a third party acccount (identified via 
   [IIBAN], [IBAN] or some other means) elsewhere in the world.
   Responses to such requests may include multiple viable 
   settlement paths with differing fees, temporal parameters 
   (execution speed, availability), reversal/cancellation terms,
   legal jurisdiction traversal, etc.

.bp
.LP
.MH 2 "Soft Requirements"
.LP
.in 3

Soft requirements include:

 * Maximizing the number of potential of problem domains for which
   the protocol may be successfully deployed.  (Best seen by way
   of contrast with established protocols' general industry segment
   orientation, eg: FIX's market orientation, OFX's consumer 
   orientation, and SWIFT's institution orientation.)

 * Minimize assumptions regarding protocol transport, security
   encapsulation, and pre-existing trust relationships.
   (Flexibility in this area allows, for example, the establishment
   of trusted channels with minimal wire-level overheads to support
   potential deployment to highly latency-sensitive environments.)

.bp
.LP
.MH 1 "The Internet Financial Exchange (IFEX) Protocol"
.in 3

The Internet Financial Exchange (IFEX) protocol provides a mechanism
for the identification, negotiation, description, execution and 
management of financial transactions over their lifetime.  It can
be used with arbitrary financial instruments, currencies or 
currecy-like commodities, and utilize arbitrary settlement systems.

.MH 2 "Preliminaries"
.MH 3 "Scope"
.in 3

IFEX limits its scope to that of message content.  It remains
neutral with regards to:
 * Asset type
 * Settlement network
 * Trust model
 * Communications topology
 * Transport protocol
 * Security encapsulation
 * Risk model

.MH 3 "Specification Language"
.in 3

Message content is defined in the [JSON-SCHEMA] format.

The format was selected for its relative familiarity to
a large number of programmers, as well as its structure, 
concision, extensibility and type affinity, despite its 
relative novelty within the Internet Standards Draft 
document stream.

.MH 3 "Transport Neutrality"
.in 3

IFEX utilizes a request/response model over a point to point 
topology in in most cases, though the event notification 
(multicast or broadcast) model is also supported due to its 
importance to major parts of the financial messaging 
community (see Related Functionality, above).

Subject to desired topology constraints, IFEX can be deployed
via multiple transports, for example unix domain sockets, 
[TCP], [UDP], [XMPP], or [ZEROMQ].

.MH 2 "Concepts"
.MH 3 "IFEX Nodes"

IFEX Nodes are participants within an IFEX network.

.MH 3 "IFEX Links"
.in 3

IFEX Links are logical communications channels (eg. transport 
layer sessions) opened between two or more IFEX Nodes in order to 
faciliate message passing.  In the event that a transport layer 
does not inherently support sessions, an IFEX Link is loosely
considered to be temporally bound between the first and last 
communications between the IFEX Nodes on that channel.

.MH 3 "IFEX Transactions"
.in 3

Financial transactions are the foundation of IFEX.  They are identified with a Financial Transaction IDentifier (FTID), and may transition through a discrete series of states throughout their lifetime.

.MH 4 "Financial Transaction ID (FTID)"
.LP
.in 3

Financial transactions are identified with a Financial Transaction
Identifier (FTID; pronounced '[EFF]-tid').

The FTID for a transaction may be created by any party, however in 
practice this will usually be the originating party or "sender".

A FTID is a 29 to 61 characters long and consists of three required
and one optional element, in the following order:

 * Account of Interest Identifier (AOI; 8-34 characters)
   An arbitrary capitalized alphanumeric identifier that is used
   to identify the financial account of concern. Note that while 
   the length of this field is adequate for an [IIBAN] or [IBAN]
   to be used as the AOI, the use of an IIBAN or IBAN is NOT a 
   requirement.
    - Examples: AA12011123Z56000 (Example IIBAN)
                0000007          (Example legacy, sequentially
                                  allocated account number;
                                  note that sequential allocation
                                  is NOT recommended)
 MT84MALT011000012345MTLCAST001S (Example of a Maltese IBAN)
                K18DS4XP         (Example randomly allocated AOI)

 * Ledger of Interest Identifier (LOI; 1-4 characters)
   An optional, one to four character alphanumeric identifier that
   is used to identify the financial ledger within the financial
   account of concern. This optional identifier is intended to 
   ease the support of multi-currency accounts, ie. those with 
   multiple ledgers.  Note that while the length of this field is 
   adequate for an [X-ISO4217-A3] or [ISO4217-A3] currency code to
   be used as the LOI, their use is NOT a requirement.

    - Examples:
       CNY    Perhaps indicating Chinese Yuan Renminbi in a system 
              only incorporating currency-specific ledgers within
              the legacy ISO4217 scheme.
       XBTC   Perhaps indicating 'Bitcoin' under X-ISO4217-A3.
       ZUSD   Perhaps indicating the 'United States Dollar' under
              X-ISO4217-A3.
       0      Numeric ledger identifier, understood only by the
              originating party.
       FWIW   Random ledger identifier, understood only by the
              originating party.

 * UTC Second of Origination (UTCSO; 14 characters)
   The UTC time of transaction origination, expressed in most to
   least significant order.
    - Example: 20120131032251 (ie: 2012-01-31 @ 03:22:51AM UTC)

 * Intrasecond Financial Transaction ID (IS-FTID; 5 characters)
   An arbitrary capitalized alphanumeric identifier to 
   distinguish the transaction from others made within the same 
   Account of Interest (AOI) and UTC Second of Origination (UTCSO).
    - Example: Z4N6S

Examples of a complete FTIDs, with and without the optional LOI 
components, are as follows:

  AA12011123Z56-20120131032251-Z4N6S
  AA12011123Z56.XBTC-20120131032251-Z4N6S

In addition to a complete FTID, the final 20 character portion of
the FTID that excludes the Account of Interest (AOI) specifier may 
be referred to as the Ledger-Local Financial Transaction Identifier
(LL-FTID); ie. for the examples above, '20120131032251-Z4N6S'.

.bp
The FTID and LL-FTID formats may be expressed in ABNF [RFC5234] as follows:

 ftid         = aoiportion dash utcso dash isti
                ; eg: 'AA12011123Z56-20120131032251-Z4N6S',
                ;     '00000007.ZUSD-20120131032200-7H3WS',
                ;     'MT84MALT011000012345MTLCAST001S.ZMYR-
                ;      20121110090807-N3YP9',
                ;     'K18DS4XP.FWIW-00010203040506-ZZZZZ'

 llftid       = utcso dash isti
                ; eg: '20120131032251-Z4N6S',
                ;     '20120131032200-7H3WS',
                ;     '20121110090807-N3YP9',
                ;     '00010203040506-ZZZZZ'

 aoiportion   = aoi / aoi period 1*4char
                ; eg: '00000007.B',
                ;     'AA12011123Z56.XBTC',
                ;     'MT84MALT011000012345MTLCAST001S.ZMYR',
                ;     'K18DS4XP.FWIW'

 aoi          = 8*34char
                ; eg: '00000007',
                ;     'AA12011123Z56',
                ;     'MT84MALT011000012345MTLCAST001S',
                ;     'K18DS4XP'

 utcso        = 14digit
                ; eg: '20120131032251',
                ;     '20120131032200',
                ;     '20121110090807',
                ;     '00010203040506'

 isti         = 5char
                ; eg: 'Z4N6S',
                ;     '7H3WS',
                ;     'N3YP9',
                ;     'ZZZZZ'

 char         = digit / caps-letter
 digit        = "0" / "1" / "2" / "3" / "4" / "5" / "6" / "7" /
                "8" / "9"
 caps-letter  = %d65 / %d66 / %d67 / %d68 / %d69 / %d70 / %d71 /
                %d72 / %d73 / %d74 / %d75 / %d76 / %d77 / %d78 /
                %d79 / %d80 / %d81 / %d82 / %d83 / %d84 / %d85 /
                %d86 / %d87 / %d88 / %d89 / %d90   ; ie. capital A-Z
 period       = "."

NOTE (2012-10-18): UTCSO specification will be revised for greater 
     (but necessarily incomplete) validation of date/time values.

.bp
.MH 4 "Financial Transaction State"
.LP
.in 3

In order to unify disparate settlement systems and their particular processing requirements, IFEX mandates that all financial transactions MUST be considered to be in one of a small number of basic states at all times.

IFEX divides financial transaction states in to three core phases:

 * Pre Phase
   All time prior to the establishment of a live transaction.  This
   may include, for instance, the gathering of quotations for the
   potential execution of a financial transaction's settlement prior
   to actual settlement initiation, some process of selection of a 
   settlement path based upon a collection of such quotations, or 
   the period prior to receiving a positive response to the finally
   issued request to execute the transaction.

    - Initial State (INITIAL)
      Covers all of the scenarios described above.

 * Live Phase
   The period of time following the successful initiation of
   execution ("EXE" message type) of a financial transaction 
   for which that financial transaction remains and valid for
   any form of processing by the originating party, including as
   a result of external parties' activity (such as the initiation
   of cancellation or refund procedures).

    - Pending State (PENDING)
      Subsequent to execution, but prior to the completion of
      settlement-related processes.

    - Settlement State (SETTLED)
      After settlement, but prior to asbolute completion.  For
      instance, the period for which a settled transaction remains
      exposed to third party cancellation or refund/reversal 
      procedures.

 * Post Phase
   After any possibility of additional transaction processing.

    - Success State (SUCCESS)
      The transaction completed successfully.

    - Failure State (FAILURE)
      The transaction did not complete successfully.

    - Partial Success State (PARTIAL)
      The transaction was partially successful, for example in
      the case where only part of the expected settlement 
      occurred, for example in the case of third parties 
      levying incalulable fees and charges on the intended
      asset volume during the process of settlement (ie. during
      the Live Phase).
      

Transaction states may be expressed in ABNF [RFC5234] as follows:

 txstate    = prestate / livestate / poststate 
 prestate   = 'INITIAL'
 livestate  = 'PENDING' / 'SETTLED'
 poststate  = 'SUCCESS' / 'FAILURE' / 'PARTIAL'

Note that implementations MAY fail to make use of certain states, in 
particular the following three states.

 INITIAL:
  Used in deployments where fiscal ledgers are modified prior
  to a transaction entering to a 'Live' state; this is typical of
  deployments that make use of IFEX's quotation functionality.

 SETTLED:
  Used in deployments where post-settlement exposure, cancellation
  or refunds MAY occur, for instance due to the finality properties
  of the settlement system(s) in use.

 PARTIAL:
  Used in deployments where partial settlement is possible, ie.
  when settlement system(s) in use permit incalculable third 
  party fees and charges to be levied during settlement.

In addition, not all state modifications are valid; in the diagram
below, state flows unidirectionally and downward at all times.

.bp
.MH 5 "Transition Diagram"

.in 5
 -------------------------------------------------------------

     INITIAL >---->--------.         
      |  |                 |          Pre States
      |  `-->----.         v                               
      |          |         |
 -----|----------|---------|-----------------------------------
      |          v         |
      |  .--< PENDING >--. |
      |  |               | |
      v  v               | |       
     SETTLED             v v          Live States
        |                | |
        `-------->-------+ |       
                         | |
 ------------------------|-|-----------------------------------
                         | |
        .---<----+---<---+ |       
        |        |       | |        
        v        v       v v          Post States
     SUCCESS  PARTIAL  FAILURE

 -------------------------------------------------------------
.in 3

In summary, transactions MAY be created in any state.  However,
valid state transitions are as follows:

 * INITIAL state MUST transition to PENDING, SETTLED or FAILURE.

 * PENDING state MUST transition to SETTLED, SUCCESS, PARTIAL or
   FAILURE.

 * SETTLED state MUST transition to SUCCESS, PARTIAL or FAILURE.

 * SUCCESS, PARTIAL and FAILURE states are final and MUST NOT
   transition.

.bp
.MH 3 "IFEX Messages"
.in 3

IFEX messages function to create, modify or describe financial
transactions between two or more parties (IFEX nodes) when
transmitted over IFEX links.  All IFEX messages are equivalent
in the sense that they may be viewed as attempts by the 
originating party to inform or modify the perception (ie. state)
that one or more remote parties hold regarding the financial 
transaction in question.

Creation and modification of financial transactions may be made
either 'by decree' or 'by negotiation'.

 * Messages made 'by decree' are those in which a message is sent
   with no attempt to negotiate acceptability to, understanding
   by, or input from the receiving party.  (For example, a
   financial market might broadcast various information across
   a 1:n-topology anycast or multicast transport based IFEX link
   in order to inform market participants about market events.)
   Note that there is not necessarily any guarantee that such a
   message has been received or processed by the recipients.

 * Messages made 'by negotiation' are those in which an attempt
   is made to negotiate the acceptance of, or some input from
   the receiving party, using a request/response style 
   transaction (ie. an "assertion/acceptance" paradigm).

.bp

.MH 4 "Message ID"
.in 3

IFEX supports the identification of each message with a Message
ID (MID) via the following message identification strategies:

 * No Message Identification (N)

   In situations where message identification is not required
   (scenarios such as real time, 'execute or forget' transactions
   running over reliable transports), IFEX allows the exclusion
   of any form of IFEX message identifier in order to support
   greater resource efficiency.

 * Sequential Message Identifiers (S)

   Use of sequential identifiers enables out of band playback
   (or network error recovery) for IFEX links such as those 
   deployed in n:n anycast/broadcast/multicast (one-to-many) 
   topologies, a common topology in financial market data 
   distribution.  (For example, an IFEX node that loses messages
   x-y due to a local network service interruption might rejoin
   the link, determine x and y, then request the lost messages
   from the originating market).

 * Arbitrary Message Identifiers (A)

   Use of arbitrary identifiers enables message identification
   and reference for scenarios where deployment of non-predictable
   (non-sequential) identifiers is preferred: for security, when
   performing legacy systems integration, or some other reason.

Peers negotiate a message identification strategy based upon
mandated field negotiation.

.bp
.MH 3 "Message Types"

 Request for Quotation (RFQ):
   Requests the receiving party or parties to provide a Quotation
   (QUO) regarding their capacity to execute AND/OR interest in 
   executing the described transaction; as opposed to actually 
   requesting its Execution (EXE).

 Quotation (QUO):
   Normally issued in response to a Request for Quotation (RFQ)
   message, this message describes the sending party's capacity to
   execute AND/OR interest in executing a particular transaction,
   usually that described in a prior Quotation (QUO).

 Execution (EXE):
   Transactions are exclusively requested to be performed (ie: 
   moved from INITIAL, the Pre Phase state, to PENDING or SETTLED,
   the Live States) via this message type.  An EXR and/or RPT will 
   usually follow from the recipient IFEX node(s).

 Execution Response (EXR):
   A response pertaining to an IFEX Message of the Execution (EXE)
   type, typically confirming execution or transitioning the 
   transaction to FAILED state.

 Request for Report (RFR):
   Requests a report (RPT) regarding the status of a particular 
   transaction from a remote party.

 Report (RPT):
   Except for the Execution response (EXR) message type in response
   to an Execution (EXE) message, any party wishing to inform 
   another of transaction status changes MUST utilize this message
   type.

.bp
.MH 3 "Party Identification"
.in 3

In recognition of the disparate nature of financial network identifiers
and to avoid lock-in, IFEX does not mandate a particular party strategy
for party identification.  In fact, party identification is completely
optional, but can be achieved via one or more of the following fields.

.in 0
 +--------------+------------------------------------------------------+
 | Field        | Description                                          |
 +--------------+------------------------------------------------------+
 | iiban        | (Internet) International Bank Account Number (IIBAN) |
 +--------------+------------------------------------------------------+
 | iban         | International Bank Account Number (IBAN)             |
 +--------------+------------------------------------------------------+
 | keysignature | Arbitrary cryptographic key signature                |
 +--------------+------------------------------------------------------+

.in 3
 iiban:
  A valid [IIBAN] or [IBAN].

 iban:
  A valid [IBAN].

 keysignature:
  Value composed of two sub-fields separated by a colon, the
  'key_type' field, and the 'signature_value' field.  Valid values
  for 'key_type' are as follows:

   +------+-------------------+
   | Code | Key Type          |
   +------+-------------------+
   | gpg  | GNU Privacy Guard |
   | x509 | X.509 Certificate |
   +------+-------------------+

  In ABNF [RFC5234] format, the signature field may be expressed as
  follows ('char' is as per this document's previous ABNF):

   signature            = signature_type_code ":" signature_value
   signature_type_code  = "gpg" / "x509"
   signature_value      = 100char
.bp
  In the 'gpg' scheme, a whitespace-stripped version of a GPG key 
  fingerprint (obtainable via: gpg --list-fingerprints) is used as
  the 'signature_value', for example:
   gpg:9E324A1B8B2513B587F4B661B949336D344FA5D4

  In the 'x509' scheme, a fingerprint of some kind (obtainable via:
  openssl x509 -noout -in cert.pem -fingerprint), for example MD5 or
  SHA1, is used as the 'signature_value', for example:
   x509:BF2766AAD7111FCEF3DFB89EBAE73ACDDD8051A5

.in 4
name:
.in 5
Free form text representing the identity of the party in question.
Note that this does not necessarily unique between parties and 
should be used only in combination with other identification 
strategies, for display purposes.

Others...
.in 3
 - name
 - address
 - formal identifiers (references human and organizational entities)
    - tax id
    - corporate reg #
    - national id #
    - ... etc.
 - arbitrary properties
    - allow general classes only
       - allow definition of specific vocabularies outside
         of spec., but referenced.

.MH 3 "Error Description"
.in 3

Kinda like ICMP in IP... reviewed ICMP RFC and came up
with the following notes.

 - distinguish between nodes and gateways as per ICMP???
   potentially useful for settlement path policy 
   restrictions; see 11/0 below. no need to be explicit
   if this is the handling style.

 - option to define as a secondary protocol, in a similar
   fashion to ICMP being segregated from IFEX?

      3/0 = net unreachable;
      3/1 = host unreachable;
      3/2 = protocol unreachable;
      3/3 = port unreachable;
     ...... some of these could be related to specific
            errors within agreed/requested settlement 
            path under IFEX, eg: 
             - (intermediate?) asset unobtainable
             - destination [permanently?] unreachable
                 . eg: IBAN doesn't exist.
                       Settlement nework no longer avaialble.
             - destination unknown

      3/4 = fragmentation needed and DF set;
     .... relates to alternate policy-based limitations,
          for instance retry and/or timeout policy.
      3/5 = source route failed.
     .... most obvious parallel is settlement path
          specification.

     11/0 = time to live exceeded in transit;
    ..... path timeout? allow specification of no other
          parties, asset types, or jurisdictions being 
          involved and this type of failure message?
     11/1 = fragment reassembly time exceeded.
    ..... as per 3/4

     12/0 = pointer indicates the error
    ..... similar to notion of using field-based 
          feedback for input errors.
      4/0 = source quench
     .... should be proactively handled with retry
          policies instead?  maybe still useful?

      5/* = redirect based on various things
     .... presumably not useful.

  <8|0>/0 = echo/reply
<13|14>/0 = timestamp/reply
<14|16>/0 = info req/reply
     .... presumably not useful


Example errors:

 - MESSAGE NOT ACCEPTED
    - parse errors
       - message too big
       - structural parse error
    - field-specific input error
       - specific field
    - cryptographic error
       - signature invalid
    - temporary processing error (retry later)
       - optionally lengthen retry time?
    - business level error
       - not authorized
          - message type-specific?
          - message state modification?

 - MESSAGE ACCEPTED
    - TRANSACTION LEVEL ERROR
       - possible to have a recoverable/temp one?
          - include interaction with retry policy
          - estimated processing time 
          - alternate settlement path report
          - optionally AUTOMATED transition to 
            FAILURE

       - temp/perm unspecified processing error
          - retry flag? could just use tx state modification?


Possible delineations of error classes:

 - message level vs. transaction level
    - most critical distinction
    
 - message accepted vs. not accepted
    - seems more useful than some of the below 
      distinctions from an implementer's perspective
       - complex/spurious in certain communications
         topologies, ie: broadcast/multicast

 - input vs. processing
    - useful?
       - kinda distinguishes between 'throw back to user
         with specific feedback' and 'transaction level'
         though the latter will likely be translated to
         an alteration of transaction state (ie. FAILED)
         so is perhaps of dubious use.

 - transaction level vs. message-level vs. field-level
     - 'transaction state reflected' vs. 'should be 
       a 'temporary error' (for the latter two cases)...

 - temporary vs. permanent
     - the main thing is that if this distinction can be
       made by the remote node then it's only going to
       relate to the overall transaction state (ie. 
       FAILED is permanent, otherwise it's not... 
       except perhaps in that case that the message was
       a QUO response, in which case the receipient node
       might like to either leave open the potential for
       a revised and less-specific RFQ... timing out if
       not received?)
     - in other cases, the ability for a human or process
       to modify the request is going to be determined
       based upon the specific transaction stimulus and
       local system on the sending side ... so it's really
       not meaningful to talk about temp vs. permanent
       since it's implementation and/or situation specific
     - conclusion: not useful as a distinction.

 - technical vs. business
    - as per [EBICS] which has such error classes
      ('general technical error' & 'general business error')
    - difference is worth sharing?
       - if this occurs on a remote system then there
         is little purpose in being overly explicit 
         since the only meaningful information that
         could contribute to a solution is whether it
         is temporary or not; and/or when to retry.
          - specific temporary states could be negotiated
            as a mutual vocabulary and reported via RPT
            messages (eg. 'transaction in regulatory hold')
            rather than burdening the base protocol with
            this requirement.
 
--- rewrite when clear ---
Rather than taking
the approach of defining an exhaustive list of input related errors,
IFEX messages MUST reference the field or fields in question using
JSON Schema.
---------------------------

.MH 4 "Temporary Errors"
.in 3
The remote system(s) MAY retry the transaction; if a Retry Policy has
been negotiated then the remote system(s) MUST abide by it.

 * OVERSIZE
   The message exceeded the maximum message size of the originating IFEX node.

 * UNKNOWN
   An unknown temporary error state occurred.

.MH 5 "Permanent Errors"
.in 3
error description
 - link to input fields to avoid copious duplication
 - general classes only
     - allow definition of specific vocabularies outside of
       spec., but referenced

.MH 3 "Transaction Type"
.in 3

Certain situations MAY require financial transactions to be
categorized in to one or more Transaction Types.

IFEX therefore allows financial transactions to be associated
with one or more Transaction Type categories, either in 
a free-form manner or linked to an agreed Transaction
Type vocabulary.

Outstanding:
 * When and how to negotiate transaction type affinities?

    * Use of JSON Schema to specify makes sense

    * Presumably normally in INITIAL state (RFQ, QUO)

       * Quotation selection should include the OPTION to 
         accept/reject transactions based upon type within
         an agreed vocabulary; this is a requirement for
         regulators at the very least, and MAY also be of
         use for individual system implementers to provide
         Transaction Type based routing or processing
         policies.

       * Lock-down of type affinity required? One assumes
         this may be a de-facto requirement since a quote's
         transaction specification should probably be 
         cryptographically signed (and thus unalterable.)
          * Such an approach makes logical sense re: any
            specific transaction specification fields,
            present or future, should be equally treated
            within a transaction.
              * What about preferencing that isn't fixed
                and is included in a quotation? Such things
                might include what information?
                 * "Route around <x> jurisdiction"?
                    * Example of end-user empowerment, a
                      'good-thing' under any circumstance

.MH 3 "Asset Specification"
.in 3

A financial transaction under IFEX MAY include zero or
more types of assets.

  * Good idea? Makes things a lot more complex for 
    implementations re: routing since many routes may
    be single route linked.

     * On the other hand, this forces implementers to
       implement PROPERLY (ie: flexibly), which might
       be a good thing.... really an important decision.

       Noting that transactions may include <x> asset
       for <y> asset, even in the digital currency for
       conventional currency buy/sell case, and this
       makes such handling unavoidable (at least in a
       directional sense), this is possibly not too
       much additional burden to expect implemented.

Assets are identified as being of a specific Asset Type within a specific Asset Class.

.MH 4 "Asset Class"
.in 3

Asset Class defines which Asset Type registry the Asset
Type field references for asset identification; ie. the
Asset Class and Asset Type fields are a hierarchical pair
that together provide an extensible, categorized 
identification system for arbitrary financial assets.

Asset classes are defined in a new IANA-managed registry,
the details of which are provided in the 'IANA 
Considerations' section, below.

Two example Asset Classes follow.

 * ISO4217-A3
   This Asset Class refers to [ISO4217-A3], the standard
   registry for three letter currency codes used globally
   with conventional currencies.  This Asset Class is managed
   by the International Standards Organization (ISO).
   Example types beneath this Asset Class are 'NZD' (New 
   Zealand Dollar) and 'LAK' (Lao Kip).  

 * ISO4217-A3-X
   This Asset Class refers to the [X-ISO4217-A3] proposal for
   a new, superset-compatible, IANA-managed code set based
   upon the ISO4217 Alpha-3 extended code set.  It includes
   codepoints such as 'XBTC' (Bitcoin).

.MH 4 "Asset Type"
.in 3

Asset Type defines which particular asset is being referenced within the
Asset Class defined registry.  Together, these fields provide extensible
identification of arbitrary financial assets.

For example, in the Asset Class 'ISO4217-A3', the Asset Type 'LYD' references the Libyan Dinar.

.MH 4 "Asset Quantity"
.in 3

Assets may be specified using any of three methods.

 * Decimal quantity of a certain type of asset in its
   default (or whole) denomination, as per conventional
   finance.  For example '1.23' of the Asset Type
   'MYR' (Malaysian Ringgit) within the Asset Class
   'ISO4217-A3' (ISO4217 Alpha 3) would represent
   one 'ringgit' and twenty-three 'sen'.  Similarly,
   '1.00000001' would represent one whole bitcoin plus
   one unit of the fraction colloquially known as a
   'satoshi' after the pseudonymous Bitcoin author.

 * Market based assets such as stocks of listed companies
   may be identified in one of two ways.

    - The IMIC Asset Class

      Within the IMIC Asset Class, an additional Asset 
      Market field is used.  An [IMIC] code is assigned
      to the Asset Market field to define an internet-based
      financial market in a manner that is superset-
      compatible with the ISO's existing Market 
      Identification Code (MIC) standard [ISO10383].
      Beneath the market, Asset Type is used to identify 
      either the market-specific asset in either the
      market-native format or through an [ISIN] (in the
      case of multi-market assets traded on that market).

      For example, an asset specification using the 
      'IMIC' Asset Class, the 'XNAS' (or NASDAQ) market,
      and the Asset Type 'PHII' would identify the
      stocks of 'PHI, Inc.', a helicopter company.

    - The ISIN Asset Class
      Under the 'ISIN' Asset Class the Asset Type specifies
      the [ISIN] of a financial asset.  The key difference 
      with [IMIC]-based specification is that ISIN specifies
      only an asset and does not provide a mechanism for 
      identifying which market it is traded on; ie. ISIN is 
      often used with multi-market assets.

 * Individual assets identified by per-instance identifiers.
   This provision seeks to handle assets such as private
   bonds, contracts and warrants, transferrable options, 
   complex financial instruments, serial-numbered notes,
   coins, or precious metal ingots with unique identifiers
   that, whilst commonly traded, MAY lack any notion of a
   consolidated market.

.MH 3 "Transaction Terms"
.in 3

IFEX supports the negotiation of various important terms surrounding a
transaction.  IFEX's capacity to make such terms succint, explicit and
machine parseable offers a significant benefit over many existing 
settlement systems that often define such terms in offline legalese.

.MH 4 "Handling Policies"
.in 3

Failure, reversal or cancellation is frequently encountered in many
mature financial systems; a fact to which commercial escrow service
providers bear adequate testament.

(Explicit policies should be possible to define:
    - who pays fees
    - regulatory ingress handling
    - fraud liability shift
)

.MH 4 "Timeout Policy"

(An explicit timeout policy should be possible to define.)

.MH 4 "Retry Policy"
.in 3

(An explicit retry policy should be possible to define.)

.MH 3 "Temporal Specification"

 - temporal specification
    - theoretical vs. practical (unforeseen delay, regulatory
       hold, etc.)
    - unknown support
    - min/max
    - range
    - average
    - guarantee
    - estimate?
    - timezone clarity
    - ... probably should use XML format.
    - various dates (at each level of settlement path)
       - order date
       - dates of attempted action

.MH 3 "Arbitrary Properties"
 - arbitrary properties
    - dividend preferencing for some assets
    - information resulting from localized legislative requirements

.MH 3 "Fee/Tax/Discount Support"
.in 3

Fees, taxes and discounts are often a part of a mature financial 
network.  Previously, poor handling of these parameters at the 
protocol level has resulted in inelegant, ad-hoc, system-specific
solutions (a prime example is the complex realm of United States
state tax calculation).

IFEX recognizes the requirement for various types of fees, taxes
and discounts and provides broad support using a two-class 
approach, respectively termed 'calculable' and 'incalculable'.

Calculable fees are preferable in that they enable financial
transactions to be executed between parties that do not require
addition temporal overhead due to redundant communcations and 
processing at the processor (recipient) node(s).

.MH 4 "Calculable"
.in 3

A calculable fee, tax or discount is one in which an algorithm
executing on a node considering or privy to the transaction
CAN be supplied with adequate information to calculate the
appropriate fee, tax or discount's effect upon a financial 
transaction's overall execution and settlement.

For example, a financial transaction in a certain type of good or
service MAY be subject to a fixed, 3% tax at the state or province
level of the local jurisdiction in which the financial transaction
occurs; this is frequently the case in the United States). In such 
cases, the node may describe the information to other parties (via
a message of the RPT type) itself SHOULD be able to explain this
information to connecting parties such that they can easily
estimate cost for end users on potential transactions.

.MH 4 "Incalculable"
.in 3

An incalculable fee, tax or discount is one in which an algorithm
executing on any node considering or privy to a transaction
CAN NOT be supplied with adequate information to calculate the
appropriate fee, tax or discount's effect.

For example, a transaction with a particular merchant may be subject to a 3.99 NZD (New Zealand Dollar) discount when a certain voucher code is supplied.  In this case, it would be beneficial for both the system representing the end user (potential purchaser of some good or service) had this information available.  However, because for reasons of fraud prevention third party systems cannot be privy to the description of which voucher codes are valid or have been previously used, it is necessary to pass the incalculable transaction to the processing party in order to determine the validity of voucher-based discounts.  In such a case, the merchant-side processing node MUST provide a revised Quote (QUO) to the originator detailing the proposed resulting impact on the overall transaction.  In extreme cases, it MAY be possible (though undesirable) for the nodes to negotiate the immediate settlement of the transaction, wherein the merchant-side processing node MUST provide a Report (RPT) to the originator detailing the final impact on the overall transaction.

fee/tax/discount support
 - type
    - tx based, affects all settlement paths
    - "node-local", or "transaction-linked" (affects all settlement paths)
    - settlement path linked
   ... providing for both means shorter messages where 1+ all-path
       taxes/fees/discounts exist.
   ... not providing for both is simpler. seems better. 
       premature optimization... and all that! ;)
 - locally levied/withheld, or remotely (3rd party)
 - identifier
    - authority / specific fee/tax/discount type
    - calculable cases
       - rationale (%-based, tiered, flat, etc.)
         - option to sidestep variants based upon peer-estimate vs. exhaustive specification?
    - incalculable cases
       - quotation based, *possibly* typical % to aid in est?
         - feeds back to need for reputation system (complex trust metrics)

.MH 3 "Settlement Path"
.in 3

Settlement paths are a core feature of IFEX: by allowing IFEX Nodes to reason meaningfully and in real time about available settlement paths, IFEX creates a free market for financial settlements and enables redundant financial routing.

To acquire potential settlement paths, IFEX Nodes issue a Quotation Request (RFQ) message to peers.  Some of these peers MAY respond with Quotation Response (QUO) messages, each of which contains information regarding one or more potential settlement paths.

The originating node considers the resulting quotation(s) and MAY select one as appropriate for execution based upon local policy.  The originating node then sends an Execution Request (EXE).

In order to prevent undue latency and network overhead caused by sending one Quotation Request (RFQ) message to all peer IFEX Nodes, per transaction, Quotation Response (QUO) messages may provide arbitrary periods of validity for each of the settlement paths offered in Quotation Response messages.  In the case that Quotation Responses have previously been received by the originating node, these MAY be considered on a "newest quote from identical node with identical requirements takes priority" basis with the newly received quotations, or may be considered locally without creating an RFQ / QUO process for the transaction at all.

When an Execution Request (EXE) is sent to effect a given transaction, it references the message identity of the Quotation Response (QUO) upon which it is based.

When multi-hop paths are used in settlement, individual IFEX transactions may be created between IFEX Nodes participating in a given hop. For example, given the multi-hop path:

  A -TX1-> B -TX2-> C

1. [TX1] IFEX Node 'A' may issue a Quotation Request (RFQ) for delivering funds to an IIBAN associated with IFEX Node C.
2. [TX1] IFEX Node 'B', thinks that it can deliver to C (for a fee).  Because their IFEX Link is not permanent, Node 'B' seeks to verify this immediately as follows.

 2.1. [TX2] IFEX Node 'B' opens an IFEX Link to Node C, creates a new IFEX transaction, and asks IFEX Node C in a Quotation Request (RFQ) message if it wouldn't mind receiving some free money from IFEX Node 'A'.
 2.2 [TX2] IFEX Node 'C' graciously indicates its willingness to receive free money at the IIBAN in question (simultaneously indicating its validity) by replying with a QUO message to this effect.

3. [TX1] IFEX Node 'B' is now safe in the knowledge that the transaction can be effected with IFEX Node 'C'.  It responds to the original IFEX Node 'A' Quotation Request (RFQ) with a Quotation Response (QUO) including a small fee.
4. [TX1] IFEX Node 'A' selects IFEX Node B's quotation response from the set it received due to having lower temporal and/or fee requirements, issuing an Execution Request (EXE) to Node 'B'.
5. [TX1] IFEX Node 'B' receives the Execution Request (EXE) from IFEX Node 'A'.
6. [TX1] IFEX Node 'B' receives a Report (RPT) From IFEX Node 'A' indicating that funds have settled (transaction state: SUCCESS) and acknowledges this after verification with a Report (RPT) message.

 6.1. [TX2] IFEX Node 'B' issues an Execution Response (EXR) to Node 'C', indicating that TX2 has entered PENDING state.
 6.2. [TX2] IFEX Node 'B' forwards funds to Node 'C'.
 6.3. [TX2] IFEX Node 'B' issues a Report (RPT) message to Node 'C', indicating that TX2 has entered SUCCESS state.
 6.4. [TX2] IFEX Node 'C' acknowledges this with a Report (RPT) message.

7. [TX1] IFEX Node 'B' issues a Report (RPT) message to Node 'A', indicating that TX1 has entered SUCCESS state. (Possibly including cryptographic proof from IFEX Node 'A')
8. [TX1] IFEX Node 'A' acknowledges this with a Report (RPT) message.

(Note: see mscgen diagrams)

settlement path
 - aggregate path
    - multi-step support
       - network identification
       - risk exposure
          - temporal specification (as above)
          - reliability
          - legal jursdictions traversed
          - transparency (status tracking availability...)
       - conversion regimes (FX...)
    - sum total of above
 - multi-path
    - split transfer for security/reliability

.MH 3 "Transaction References"
.in 3
The Financial Transaction IDentifier (FTID) of a transaction may be used within a message for following purposes:

.in 4
Assertion:
.in 5
The creation of a Financial Transaction IDentifier for a transaction that has not yet had such an identifier specified.  The association process MUST occur in a Request for Quotation (RFQ) message, a Quotation Response (QUO) message, an Execution Request (EXE) message, or an Execution Response (EXR) message.  Initial assertion MUST NOT occur in a Report (RPT) message. 

.in 4
Association:
.in 5
Messages prior to EXR (RFQ, QUO, EXE) message MAY reference the FTID supplied in a Request for Quotation (RFQ) message.  It can be created if none is yet known.
All Execution Response (EXR) messages MUST reference an FTID. The FITD can be created if none is yet associated.
Report (RPT) messages MUST reference the existing FTID.

.in 4
Error Recovery:
.in 5
Any error message should reference the FTID and of the message whose transaction it affects. 

.in 4
Reversal/Cancellation:
.in 5
Subject to the transaction-specific Reversal / Cancellation Policy negotiated between nodes, a node may wish to reference a transaction in a subsequent message in order to effectively reverse or cancel it by creating a new and opposite transaction.

.bp
.MH 1 "Implementation Considerations"
.in 3

.MH 2 "Financial Transaction ID (FTID) Storage"
.in 3

Financial Transaction Identifiers (FTID) MAY be stored as follows:

 1. Resolving the Account of Interest (AOI) portion with the
    local system's ledger identity (eg: IIBAN, legacy or custom 
    identifier)

 2. Using standard mechanisms for efficient datetime storage of
    the UTC Second of Origination (UTCSO) and generating this
    portion of the FTID on demand.

Under such a scheme, only the five character Intrasecond 
Financial Transaction ID (IS-FTID) need be stored against
individual transaction records.

.MH 2 "Transaction Status Flow"
.in 3

The IFEX transaction status vocabulary and transition flow is 
believed to represent a reasonable basis for the common 
description of transaction state transition across disparate 
financial systems, removing the historic need for system 
integrators to negotiate financial or settlement system 
specific state and state transition minutiae.

However, implementors new to IFEX may feel the model overly 
constraining, in particular a need may be perceived by some
to transition from SUCCESS to FAILURE states post-facto;
under IFEX transaction state flow rules this is necessarily
illegal for such final (poststate) transactions.  Instead, 
completed transactions in a SUCCESS state that need to be
cancelled or reversed (due to processing error, regulatory 
action, etc.) should remain unchanged and a new transaction
(or set of transactions) should be created to effect the 
inverse of the outcome of the original transaction's net 
settlement.  Such a transaction (or set of transactions)
SHOULD reference the original transaction in order to provide
a means for the remote party or parties to associate the
initial and related transactions.

.MH 2 "Systemic Limitations"
.in 3

Implementers should be aware of the following systemic limitations.

.MH 3 "Maximum Transaction Throughput"
.in 3

Each Financial Transaction ID (FTID) contains an Intrasecond Financial
Transaction Identifier (IS-FTID) component whose 5 character length limits
the available namespace to 60,466,176 transactions per second,
per Account of Interest (AOI).

High volume systems requiring a greater number of intrasecond
transactions MUST select an Account of Interest (AOI) population 
strategy that recognizes and avoids this limitation.

.MH 2 "Internationalization"
.in 3

.MH 3 "String Representation"
.in 3

The decision was made to utilize JSON, a necessarily UTF-8 driven
standard despite its wire-level inefficiencies, in order to guarantee
a reasonable, guaranteed inheritable degree of internationalization 
in string specification.

.MH 3 "Extensibility"
.in 3

Rather than taking the flawed approach of attempting to second-guess
the common sum of every present and future global financial
messaging requirement in a centralized, technocratic bid at world
domination, IFEX instead recognizes that local requirements will
always exceed perceived requirements when specifying global
protocols: particularly those in long term use.  Thus, a minimalist
and proven approach is taken.  This philosophy is in line with the
accepted mantra of "do one thing, and do it well".  The results are
visible in the protocol's approach to the notion of currency and 
commodity, settlement system, and almost any other aspect of an
IFEX message.

.bp
.LP
.MH 1 "Protocol Design Considerations"
.in 3

This section details considerations made during the design of IFEX in an
attempt to explain the reasoning behind specific design decisions to
implementing or technical audiences.

.MH 2 "Transport Neutrality"
.in 3

Transaction protocols such as [HTTP] and [JSON-RPC] were
necessarily avoided on account of their lack of support for
arbitrary communications topologies.

.MH 2 "Message Identification"
.in 3

The IFEX policy of transport and communications topology 
neutrality necessitates a broader approach to message 
identification than classical [TCP]-based transaction-oriented
application level protocols.  

This is because the use of unreliable transports AND/OR 
broadcast/multicast (one-to-many) topologies MAY occur.
At the other extreme, an IFEX deployment MAY make use of a  
reliable transport with bandwidth and latency sensitivity 
and opt to exclude message indentification overheads entirely.

.MH 2 "Financial Transaction ID (FTID)"
.in 3

The Account of Interest Identifier (AOI) is 13 characters to facilitate
the straightforward association of an IIBAN with a transaction; note
however that the use of IIBAN for AOI is NOT required.  (Use of IIBAN
relieves IIBAN-based implementations of the need to store the entire
FTID; instead they MAY store only the subsequent (UTCSO and ISTI)
portions against the internal transaction ledger(s) in question.)

The second-level granularity of the temporal portion (UTC Second of
Origination, or UTCSO) was chosen in order to provide a reasonable
mechanism for the immediate association of a FTID with an adequately
specific point in time to facilitate sorting.  The day-based
granularity alternative would reduce the overall length of a FTID
significantly but was discounted as a probable cause of increased
human error, particularly on numerous existing systems that MAY
operate partly or wholly upon local timezones instead of UTC.

The length of the Intrasecond Transaction Identifier (ISTI) was
set at 5 characters as it rounds out the overall FTID length neatly
to 32 bytes and provides what is felt to be an adequate maximum of
60,466,176 transactions per AOI per second.  (Implementors requiring
scalability beyond this number of transactions per second should
refer to the Maximum Transaction Throughput section for
recommendations).

.MH 2 "Fee/Tax/Discount Support"
.in 3

It is recognized that a frequent case is that a fee, tax or discount
will affect all settlement paths, for instance jurisdiction-based
taxation usually falls in to this type of situation.

Whilst a mechanism for the description of such cases was considered
at a disparate level to that of settlement paths in order to realize
shorter message lengths (ie. removing the need to redundantly
specify the same fee, tax or discount on duplicate settlement paths),
this was ruled out on the grounds that removing a secondary location
within messages for the specification of equivalent cases was a
simplification and therefore desirable.  In addition, the
optimization of such cases at the wire-level is possible to effect
through alternate wire-formats (or 'middleware' in today's
enterprise parlance), and it has been previously noted that
"Premature Optimization is the Root of All Evil".

.MH 2 "Transaction Types"
.in 3

While other financial protocols have seen fit to categorise 
transactions in to fixed categories, IFEX avoids such
a scheme due to its goal of maintaining a maximum breadth of 
deployment applicability.  This decision also serves to
remove the frequently observed potential for latter accretion
of redundancy in protocols where the sum total of all
future requirements failed to be perceived at the protocol
design stage.

The need for specific deployments to include mechanisms
for transaction categorisation is, however, acknowledged
with IFEX's capacity for parties to establish agreed 
vocabularies of transaction types to suit deployment
time requirements.  In addition to more specific and/or
one-time vocabularies, it is anticipated that common
common transaction type vocabularies will be established
to cater to repeating industry, market and regulatory 
jurisdiction level requirements; possibly even by industry
bodies and/or regulators themselves.

Multiple transaction types are allowed per transaction
due to this perceived need for multiple transaction type
affinities per transaction, ie: local system or 
deployment linked, industry or market linked, and 
(possibly multiple) jurisdiction specific regulatory
requirement linked transaction types may be associated
with a single transaction.

.MH 2 "Transaction Phases"
.in 3

As may be assumed, various delineations have been used by
specific communities to analyze the lifetime of a 
financial transaction.

For example, during research we noted the following phase 
delineations:

 * Exploration/Structuring/Implementation

 * Information/Agreement/Enforcement or Adaptation

 * Entity setup & review/
   transaction review & approval/
   transaction verification (Purchase requisition approval; Cruzbuy requisition approval; cash receipt form approval; time report approval; transfer of expense approval ) / 
   post tx report review (Goods receipt confirmation; manual signature on check) /
   Reconciliation (review ledger vs. independent datasource: accts receivable or bank) /
   Balance analysis (Review of ratios, trends, or year-to-year comparisons
   to identify potential errors. In other words: Comparison of monthly
   expenditures with prior years’ amounts; comparison of expenditures to budget)

 * Recording and posting / adjusting and closing / trial balance and
   statement complilation

 * Recording / classifying / summarizing / interpreting

Timing modes:
 - prepayment
 - simultaneous payment (dvp)
 - postpayment

Effectiveness/efficiency measurements:
 - cost
 - quality
 - productivity
 - risk

Risks:
 - source #1
    - market risk (delay between agree/deliver/pay phases)
    - credit risk (time diff between delivery & payment)
    - liquidity risk (delayed payment or delivery)
 - source #2
    - error in accting classification
    - number or arithmetic error
    - unintentional asset misdirection error
    - misappropriation
    - fraud
    - regulatory/contractual/policy noncompliance



Transaction process control standards
  Appropriate – The transaction is directly related to goals.
  Valid – The transaction is allowed by policy, law, contract or standards.
  Reasonable – Amount being paid or received is fair.
  Funded – Sufficient funding exists.
  Accurately recorded – Amount consistent with value and free from error.
  Supportable – Consistent with supporting docs, standard, situation or practice.
  Timely – Date associated with transaction is accurate.

.in 3
Financial controls:
.in 5
1. Transaction initiation review and approval	
Review and approval of expense reimbursement request
Review and approval of a CruzBuy requisition
Review and approval of a transfer of expenditure
Review and acceptance of a sponsored award contract
Review and approval of a recharge
Review and approval of Financial Information System, Payroll Personnel,
CruzBuy system user access forms
2. Asset receipt verification	
Review and approval of a receiving report
3. Post-transaction review	
Review and certification of transactions appearing in the general ledger
Review and certification of monthly Purchasing Card transaction reports
Review and certification of Distribution of Payroll Expense reports
Review and certification of Financial Information System or Data Warehouse
transaction edit (suspicious transactions) or exception (error) reports
4. Balance reconciliation	
Monthly reconciliation and certification of summarized accounts receivable
ledger balance to detailed debtor accounts balances listing
Monthly or quarterly petty cash account reconciliation and certification
5. Balance analysis	
Review and approval of entertainment expenses for unusual fluctuations in
the balance over the course of a year
Analysis and certification of material budget to actual expense differences

.in 3
Automated Transaction Controls
.in 5
Control Procedure Type	Examples
1. System access functions	
Financial Information System password access requirement
2. Data input	
Date or telephone number format checking
3. Data validation	
Organization, fund, and/or account code validation
4. Data processing	
Automatic summarization and posting of invoice payment data to the general
ledger

.in 3
Control procedure strength levels
.in 4
The strength, or level of reliance, placed on a financial control procedure
in managing risks depends on three key factors.
.in 5
(1) Control quality objectives of the control procedure;
(2) Skills, qualifications, and accountability of the individual assigned to perform the procedure; and
(3) Adequacy of separation of duties within the process.

.in 4
OK so here's the control procedure classifications...
.in 5
Strength / Objective / Staff Skills + Quals / Separation of Duties
Strong/Complete, thorough transaction review / Strong knowledge and analytical skills, and experience / Adequate
Moderate / Complete, but cursory; or limited scope, but thorough transaction review / Somewhat knowledgeable and experienced, with adequate analytical skills	Adequate
Weak / Cursory and/or limited scope transaction review / Minimal knowledge, experience and/or analytical skills / Inadequate


.MH 2 "Robustness Considerations"
.in 3

As per [ROBUST] and to avoid situation such as [ISO20022CR103],
IFEX encourages a "be liberal in what you accept, but conservative
in what you believe" philosophy.  This philosophy is manifest in
decisions to:

 * Require only definitively essential fields.

 * Build extensibility in to the base protocol.

 * Mandate the avoidance of transaction failure where unrecognized
   information is supplied by one of the communicating parties.

 * Delegate mandated field specification to communicating parties.

.MH 3 "Value Conceptual Simplicity"
.in 3

The majority of financial messaging requirements identified through
the extensive research made during the design of IFEX were relegated
to the domain of implementation through extensions; this includes
market and jurisdiction-based requirements in addition to financial
transaction metadata that may only be relevant between a small 
number of parties ("bespoke integrations" in UK parlance).

Whilst it may be argued under this guideline that the extensibility
notion facilitates the uncontrolled reduction of conceptual
simplicity, it is felt that since the user communities in question
are the only ones affected it is reasonable to offload to them
the responsibilities of this situation.

.MH 3 "Minimization of Dependencies"
.in 3

The notion of this guideline is not to blindly trust other nodes.

With regards to Pre State financial transactions, this is manifest
in the recommendation to test input given by other nodes and, where
possible, against additional nodes' reported status for the same 
financial transaction.  In any case, IFEX is perceived as a 'light
touch' protocol in that it does not mandate extensively local 
processing algorithms and thus delegates the responsibility of 
correct style to implementers: good luck, and publish your results.

With regards to subsequent state financial transactions and/or the
transition to such, the agreement of a client to provide funds
for settlement is in most cases a reasonable and potentially
legally binding justification for the expense of computational
resources.

.MH 3 "Verification Where Possible"
.in 3

IFEX attempts to strip out most redundancy; see 
Fee/Tax/Discount Support under Internationalization for an 
example.

The linear progression of financial transaction state toward the
final states (Post Phase) facilitates a reduction of impact
with regards to the potential loss of intermediate financial
transaction state updates (ie. lost IFEX messages).

In addition, IFEX's communications paradigm neutral approach 
means that state-loss situation may result in queries to other 
parties to a transaction may reliably update state without
nasty surprises, ie: whilst current remote state COULD be
incorrect, a subset of possible remote states MUST be known
at all times.  Such information SHOULD be sufficient for
all parties to effect decisions regarding the financial
transaction in question; in particular, the cancellation 
and transition to FAILURE of financial transactions in which
financial transactions with status falling in to the Final 
State category (ie: SUCCESS or FAILURE).

.MH 3 "Protection of Resources"
.in 3

IFEX's state transition model requires that connecting parties
specify a relatively large amount of information regarding any
given transaction.  In return, responding systems provide a
very brief response.  From a network resource perspective, this
achieves the desired affect of removing threats of traffic
multiplication at the message (application) level, regardless
of the elected transport-layer protocol.

The state transition model also requires a linear progression
between financial transaction states and their classes; thus,
incorrect behaviour is limited and MAY result in the 
cancellation of a transaction (ie: the reporting via a RPT
message of a financial transaction's transition to FAILED 
state by the party detecting the error).

.MH 3 "Limitation of Vulnerability Scope"

TEMPORAL:
 ... individual system can alter their perception and
trust for remote IFEX nodes based upon the state of
a transaction.

PRACTICAL:
 ... settlement terms may be negotiated to very specific
     levels.

LEGAL:
 ... the option for signed messages enables non-repudiation.

.MH 3 "Expose Errors"
.in 3

Provision has been made for error exposure at every stage of
a transaction, ie. in any Transaction State or within any
Message Type.

In addition, to provide implementers with adequate information
for the provision of error processing .... local requirements,
an hierarchical approach has been taken to error specification.
Such an approach allowed implementers to provide varying 
levels of feedback and processing activity based upon the
type of error encountered.

The relationship between [IP] and [ICMP] was reviewed to
better inform the design process.

.bp
.MH 1 "Security Considerations"
.in 3

This section is addressed to implementers and enumerates
specific security related considerations in the deployment 
of IFEX based systems.  Obviously, it is nonexhaustive;
in addition to the points enumerated below standard 
computer security measures MUST be employed, or an 
insecure system is likely to result.

.MH 2 "Transport Selection"
.in 3

As a transport neutral protocol, careful transport 
selection for IFEX deployments is critical to implementation
security.

From a security standpoint, potential transports SHOULD be 
evaluated on at least the following criteria.

.MH 3 "Traffic Analysis Considerations"
.in 3

Consider whether you need your transport to be resistant to
traffic analysis.

Two primary techniques appear to be employed to frustrate 
traffic analysis: indirect routing, and chaffing and winnowing.
(The latter by liberal definition includes the relatively well 
known field of steganography as a subset.)

.in 0
+------------------------+-----------+------------------+
| Resistance Technique   | Price     | Example(s)       |
+------------------------+-----------+------------------+
| Indirect routing       | Latency   | [TOR], [FREENET] |
| Chaffing and winnowing | Bandwidth | Steganography    |
+------------------------+-----------+------------------+

.MH 4 "Authentication"
.in 3

If your transport provides adequate authentication (for instance, some kind
of secure physical link layer) then transaction overheads can be
reduced at the IFEX message level.  Such configurations MAY be attractive
for certain classes of deployment, for example low latency environments
such as High Frequency Trading (HFT) systems.

.MH 4 "Non-repudiation"
.in 3

If your deployment environment includes adequate non-repudiation (for 
instance, internal systems within a single organization where adequate 
audit trails are known to exist and a secure physical link layer is in 
use), then transaction overheads MAY be reduced at the IFEX message 
level.  Such configurations MAY be attractive for certain classes of 
deployment, for example low latency environments such as High Frequency
Trading (HFT) systems.

.MH 5 "Encryption"
.in 3

Describe general type of algorithm in use for transport...

One time pad.
Public key cryptography.
Symmetric cipher.
 .... others?


.MH 2 "Protocol-Level Considerations"

.MH 3 "Intrasecond Transaction Identifier (ISTI)"
.in 3

To avoid disclosure of ledger transaction frequency, the Financial
Transaction Identifier (FTID) Intrasecond Transaction Identifier 
(IS-FTID) portion SHOULD be assigned pseudorandomly rather than 
sequentially.

.MH 2 "By Attack Vector"

.MH 3 "Resource Exhaustion"
.in 3

Due to the requirement for parties within IFEX to consider and 
maintain state regarding financial transactions, it is prudent to
consider the potential threat of storage and processing resource
exhuastion due to deliberate malice (as in Denial of Service 
attacks), node misbehavior and other circumstances.

Whilst overall financial transaction state differs in that in IFEX's
case it is maintained in a non node-local fashion, in broad terms
IFEX adopts a view similar to that of [SMTP].  That is, at any given
time one particular node MAY be considered to be primarily 
responsible for expected transaction state transition.

.MH 4 "Maximum Message Sizes"
.in 3

IFEX purposefully excludes fixed size limits on message structures. 
Implementers should carefully consider their bandwidth and processing
resources when determining the boundaries for acceptable messages.

.MH 3 "Traffic Analysis"
.in 3 

While traffic analysis threats are not unique to IFEX,
implementors MUST be aware that traffic analysis MAY reveal
significant amounts of sensitive financial information;
implementers SHOULD select transport strategies with this 
information in mind.

.MH 4 "Latency Analysis"
.in 3

In some cases, the outcome of a system's IFEX transaction MAY be 
possible to determine purely by analyzing the latency between the
transaction request and response components of a suspected transaction.

.MH 4 "Destination Analysis"
.in 3

Traffic analysis MAY reveal with which remote party or parties
suspected IFEX transactions are being performed.

.bp
.MH 1 "Lock-in Considerations"
.in 3

In deference to Jaron Lanier's call for humanistic concerns in
technology, it may be noted that by dealing exclusively with 
metadata concerning transactions rather than settlement mechanics
per se, Lanier's `lock-in' (the indeliberate exclusion of 
alternative approaches to value tranfer should IFEX become 
popular) is presumably largely avoided.

In addition, IFEX development included consultation with both
monetary theorists [ENDOFMONEY] and various alternate fiscal
communities ([CES], [RIPPLE]).  It is hoped that including
this breadth of perspective has reduced the risk of lock-in as 
well as increasing scope for future collaboration between the 
internet technical community and these types of communities.

.bp
.LP
.MH 1 "References"
.MH 2 "Normative References"
.LP
.in 3

[IBAN]          SWIFT, "ISO13616 IBAN Registry",
                http://www.swift.com/solutions/messaging/
                 information_products/directory_products/
                 iban_format_registry

[IIBAN]         Stanish, W., "Internet International Bank Account
                Number (IIBAN)", The IFEX Project.
                http://tools.ietf.org/html/draft-stanish-iiban-00

[ISO9362]       ISO TC 68/SC 7 (Core Banking), "ISO 9362:2009:
                Banking - Banking telecommunication messages -
                Business identifier code (BIC)", ISO 9362:2009.
                http://www.iso.org/iso/catalogue_detail?
                 csnumber=52017

[ISO13616]      ISO TC 68/SC 7 (Core Banking), "ISO 13616-1:2007: 
                Financial services - International bank account 
                number (IBAN) -- Part 1: Structure of the IBAN",
                ISO 13616-1:2007.
                http://www.iso.org/iso/catalogue_detail?
                 csnumber=41031

[ISO7064]       ISO JTC 1/SC 27 (IT Security techniques), 
                "ISO/IEC 7064:2003: Information technology -
                Security techniques - Check character systems",
                ISO/IEC 7064:2003.
                http://www.iso.org/iso/iso_catalogue/
                 catalogue_tc/catalogue_detail.htm?csnumber=31531

[RFC2119]       Bradner, S., "Key words for use in RFCs to
                Indicate Requirement Levels", BCP 14, RFC 2119,
                March 1997.  

[RFC5226]       Narten, T., and H. Alvestrand, "Guidelines for
                Writing an IANA Considerations Section in RFCs",
                BCP 26, RFC 5226, May 2008.

[RFC5234]       Crocker, D. and P. Overell, "Augmented BNF for
                Syntax Specifications: ABNF", STD 68, RFC 5234,
                January 2008.

.fi

.bp

.LP
.MH 2 "Informative References"
.LP
.in 3

[BITCOIN]       Nakamoto, S., "Bitcoin: A Peer-to-Peer Electronic
                Cash System", 2009-05-24.
                http://www.bitcoin.org/bitcoin.pdf

[BSON]          BSON 1.0. http://bsonspec.org/#/specification

[CES]           The Community Exchange System. http://ces.org.za/

[EBICS]         EBICS SCRL, SIZ, "EBICS Specification" (v2.5), May and
                November, 2011. http://www.ebics.org/index.php?id=30

[EFF]           "Electronic Frontier Foundation | Defending Your Rights
                in the Digital World". https://www.eff.org/

[ENDOFMONEY]    Greco, Jr., Thomas H. "The End of Money and the Future
                of Civilization", October 2011. Chelsea Green Publishing.

[RIPPLE]        The Ripple Project. http://ripple-project.org/

[ROBUST]        Anderson, Shenker, Stoica and Wetherall.  "Design
                Guidelines for Robust Internet Protocols".
                http://www.cs.washington.edu/homes/tom/pubs/guidelines.pdf

[SMTP]          Postel, Jonathan B. "Simple Mail Transfer Protocol",
                RFC821. August 1982.

[SWIFT2]        European Parliament, "Parliament gives green light
                for SWIFT II", #20100707IPR78054, 8th July, 2010.
                http://www.europarl.europa.eu/sides/getDoc.do?
                 language=en&type=IM-PRESS&reference=20100707IPR78054

[TEMS]          "Greece develops cashless, Euro-free currency in tight
                economy". Jon Henley, The Guardian. March 16, 2012.

[XMPP]          Saint-Andre, P., "Extensible Messaging and Presence 
                Protocol (XMPP): Core", RFC6120, March 2011.

.fi

.bp
.LP
.MH 1 "Contributors"
.LP
.in 3

The support of the following parties in the research and development 
of this proposal is acknowledged.

 * Thomas H. Greco, Jr. Monetary theorist, USA.

 * Community Exchange System (CES), South Africa.
 
 * OpenCoin, Inc., California, USA.

 * Payward Inc., California, USA.

 * Marquis de Chasse (Sauvingnon & Sémillon) Bordeaux (2008), Baron
   de Rothschild, and the pioneering new dance move they inspired -
   the ISO-sidestep (yet to acquire ISU recognition).

.MH 1 "Authors' Addresses"
.LP
.in 3

Walter Stanish 
<walter@stani.sh>
Payward Inc.
On behalf of the IFEX Project
http://ifex-project.org/

.bp
.MH 1 "Appendix 0: Examples"

Align to initial examples in use cases section.

.MH 2 "Decentralized Digital Currency Transaction"

.MH 2 "Conventional Transaction"

.MH 2 "Automated Teller Machine Deposit Report"

.MH 2 "Securities Sale in an ECN; Report to Market"

.MH 2 "B2B Transaction for Physical Goods"

.bp
.MH 1 "Appendix A: Summary of Existing Protocols"
.LP
.in 3

Compared to existing financial services protocols such as [FIX],
[OFX] and [SWIFT], IFEX proposes an open, flexible, globalized,
'legacy free'*, high performance alternative with broader deployment
potential, more tightly circumscribed scope, and ample means for the
extension.

 * 'Legacy free' refers to the removal of additional features present
   in contemporary financial protocols for reasons of backwards
   compatibility or ease of migration from still earlier systems.

The primary protocols identified in related areas are [FIX], [OFX]
and [SWIFT].  The following table provides comparison at a glance
based upon the factors of general system orientation, assets
supported (currencies, market-based commodities, or arbitrary),
latency consideration, bandwidth efficiency, and
broadcast/multicast capability.

.in 0
123456789012345678901234567890123456789012345678901234567890123456789012345678
+--------+---------------+-----------------+---------+---------+----------+
| System | Orientation   | Assets          | Latency | B'width | B/M'cast |
+--------+---------------+-----------------+---------+---------+----------+
| FIX    | Market        | Curr/Comm (x)   | Low     | Low (x) | Yes      |
| OFX    | Consumer      | Curr/Comm (x)   | ?       | ?       | No       |
| EBICS  | Consumer      | ?               | High    | ?       | No       |
| IFX    | Institution   | Curr            | ?       | High    | No       |
| SWIFT  | Institution   | Curr            | ?       | ?       | ?        |
+--------+---------------+-----------------+---------+---------+----------+

To the above list of options available to financial systems implementers today,
IFEX seeks to add the following:

+--------+---------------+-----------------+---------+---------+----------+
| System | Orientation   | Assets          | Latency | B'width | B/M'cast |
+--------+---------------+-----------------+---------+---------+----------+
| IFEX   | Any and all   | Truly arbitrary | Low (y) | Low     | Yes (z)  |
+--------+---------------+-----------------+---------+---------+----------+

Notes:
 (x)  The FAST protocol provides a mechanism for FIX binary compression.
 (y)  Deployments may range from low to high-latency, as appropriate.
 (z)  Arbitrary transport layers are supported, not only point to point.

.MH 2 "FIX"
.LP
.in 3

Summary to be written...

.MH 2 "OFX"
.LP
.in 3

Created in 1997 by CheckFree, Intuit and Microsoft, the protocol
apparently aimed to provide statement download, 'stop check', intra
and interbank funds transfer, wire transfer, 'data synchronization',
bill payment, bill 'presentment' (EBPP) and financial market-based
asset management, amongst other functionality.  This functionality
largely falls under a business-to-consumer category, and does
not really tackle financial institution requirements.

Today OFX is not widely deployed, and stands as a relic of late
1990s thinking by major software vendors.  Four key issues with
OFX are as follows:

 * A clearly US-centric design, with little or inadequate
   consideration of international deployment in either protocol
   design or available documentation.

 * Inspecific precision, potentially resulting in rounding issues.

 * The enforced string and XML-based nature of the protocol is
   inefficient for low latency deployment.

 * Needless complexity. Attempts to cover largely analagous
   use cases (bill payment, inter/intrabank funds transfer, wire
   transfer) with disparate aspects of its protocol design.

.MH 2 "EBICS"
.in 3

The Electronic Banking Internet Communication Standard
[EBICS] is a relatively new protocol deployed within
parts of Europe (chiefly Germany and France) that is
used to facilitate bank-client and interbank transactions.

As with other existing financial protocols, it includes
significant 'legacy' components (explicitly supporting
at least three legacy file formats), utilizes 'upload'
and 'download' terminology that is primarily suited for
only relatively high latency financial networking, and mixes
what probably should be clearly delineated areas of concern
(cryptographic key management and algorithm selection,
business and technical level errors, party identification,
and on a more general level error and capability
specification are largely addressed within a single,
statically defined error namespace).

Though apparently intended for widespread adoption, EBICS
does not seem to be gaining much ground internationally.

.MH 2 "IFX"
.in 3

IFX is an XML-based protocol for the exchange of financial
messages that bills itself as a "content rich, well-designed
financial messaging protocol built by financial industry and 
technology leaders with decades of combined experience; 
experts who have painstakingly defined, modeled and 
incorporated real-life use cases to produce relevant and useful
business data objects", and "a consistent framework 
incorporating best-of-breed design principles, a common 
object model, a service oriented architecture that accounts 
for the interactions among those objects and carefully 
defined data definitions".

Apparently reasonably well conceived as an extensible and
unifying standard for the banking industry, in practice it does 
not appear to have considered non-institutional (eg: market related)
use cases; a major oversight for many communities.  In addition,
IFX appears to be hobbled by a combination of legacy concerns 
and overspecificity within the subset of messaging scenarios 
considered during its design; there were 2907 IFX 'tags' within
the standard at the time of writing (version 2.2).

No support appears to be given for non-[ISO4217] currencies,
nor does it appear to support non-currency commodities.

Evidence of global deployment appears limited at best.

.MH 2 "SWIFT"
.LP
.in 3

More of a 'hosted network' ("walled garden") than a protocol
per-se, [SWIFT] is the basis for many of today's international
funds transfers.  Being a centralized system, it has also been
abused as a mechanism for global, warrantless surveillance of
financial transactions. [SPIEGEL2011]

In addition to serious privacy questions, the system exhibits
many standard issues of those with centralized architectures,
for example:

 * Stifling of innovation through high monetary, bureaucratic
   and cultural barriers of entry and a general resistance
   to change.

 * Comparitively bureaucratic and inefficient operation.

 * Relative vulnerability to node failure due to a lack of
   decentralized routing.

 * Lack of trust agility [CONVERGENCE]

In short, in addition to being relatively 'closed' (in the
sense that open implementations are not available), such a
network does not accord with the core values of transparency
and openness in the internet community and as such is an
excellent candidate for replacement.  SWIFT's replacement
MAY be supported by individual nations and existing financial
institutions a means to prevent abusive surveillance
practices, high operational costs, latency and other
pervasive drawbacks.  From a user (rather than national
or institutional) perspective, replacing SWIFT with
an alternative creates greater ease of use, since the
disclosure requirements for transaction purpose, plus the
identity, physical address, telephone and email contact
details of each party put in place post-911 MAY be
perceived by users as needlessly slowing and complicating
international financial transfer procedures.

Despite its obvious limitations, for lack of alternatives
at the time of writing the SWIFT network is unfortunately
pervasively deployed across the globe.

.bp
.MH 1 "Appendix P: Philosophy"
.in 3

The effect of negotiating both mandated fields AND policies
regarding financial transaction state transition within a
protocol is that participating nodes MAY effectively negotiate 
aspects of shared state and procedure that are traditionally
outsourced to hard specification by protocol authors at
protocol design time.  IFEX's decision to avoid such an 
approach seeks to provide both longevity for the protocol
and flexibility for individual deployments.

In light of this philosophy and the accepted mantra "Do 
one thing, and do it well" one might revise the mantra 
in IFEX's case to something yet more abstract, for instance: 

  "Facilitate one thing. 
   Facilitate it fundamentally,
   facilitate it flexibly."

Whilst this approach is classically taken in comparable 
realms (such as well designed XML DTDs), combining this 
philosophy with models of state transition for protocol
specification is believed to be somewhat novel as an 
explicit philosophy within the Internet Standards Draft
document stream.

.bp
.MH 1 "Appendix S: Sales Pitch"
.in 3

This admittedly rather novel section is intended to 
summarize IFEX's benefits to various classes of potential
users.  It is hoped that in addition to the review of 
existing protocols this section may aid potential 
IFEX proponents in pitching their case to 'stakeholders';
sigh.

.MH 2 "Banks"

Sick of upgrading from ISO-x to ISO-y, while back-supporting 
vendor protocol Z and maintaining custom B2B and online 
banking protocols?

 * Minimize future integration costs and maximize business
   agility by preparing your systems to trade in arbitrary
   assets, currencies or value stores across arbitrary 
   settlement networks.

 * Compare financial routing options in real time on any
   given transaction to establish real time routing 
   capability, lowering costs and creating fault tolerance
   to increase overall system reliability.

 * Peace of mind that your core system is extensible: arbitrary
   future requirements can be met with remote parties without 
   the need to approach standards bodies and wait weeks, months
   or years for changes to get through.

.bp
.MH 2 "Businesses"
.in 5

"The banks and credit card companies have spent 50 years building a
proprietary, locked-down system that handles roughly $2 trillion in credit
card transactions and another $1.3 trillion in debit card transactions
every year. Until recently, vendors had little choice but to participate in
this system, even though - like a medieval toll road - it is long and
bumpy and full of intermediaries eager to take their cut. Take the common
swipe. When a retailer initiates a transaction, the store's point-of-sale
system provider - the company that leases out the industrial-gray card
reader to the merchant for a monthly fee - registers the sale price and
passes the information on to the store's bank. The bank records its fee and
passes on the purchase information to the credit card company. The credit
card company then takes its share, authorizes all the previous fees, and
sends the information to the buyer's bank, which routes the remaining
balance back to the store. All in all, it takes between 24 and 72 hours for
the vendor to get any money, and along the way up to 3.5 percent of the
sale has been siphoned away.
[...] 
According to a 2003 study in the Review of Network Economics, every sale by
credit card costs a merchant six times what the same sale with cash would
run. (Cash comes with its own costs, such as requiring more oversight of
cashiers, upkeep of vaults, and a bank’s services to process it.)"

               -- 'The Future of Money: It's Flexible, Frictionless
                   and (Almost) Free', Wired Magazine, March 2012.

.bp
.MH 2 "End Users"

.MH 2 "Financial Markets"

 * Trade equally in any class of commodity, currency or 
   value store.

 * Connect to the newest client and broker systems with
   lower latency and broader standards than were ever
   available with FIX and similar efforts, without losing
   the ability to support market or jurisdiction-specific
   requirements.

 * Take advantage of true extensibility: never again will
   you need to approach or wait for industry bodies in 
   order to pass standards changes, should:

    - Regulatory or situational changes mandate changes
      in your communicative requirements.

    - A dominant industry body mandates a shift to a new 
      standard that 'forgets' your requirements.

    - An industry body mandate an incongruous protoocol.

.MH 2 "Governments"

 * Facilitate increased internal and external efficiences.

 * Mandate the preparation of your systems for future
   situtations.

 * Accurately track all types of value exchange, including
   non-currency value exchange that is presently difficult
   or time consuming to attribute ownership to.

.MH 2 "Online Payment Processors"

.MH 2 "Software Vendors"

 * Sell upgrades to existing products.

 * Innovate new products based upon the new IFEX capabilities.


.MH 1 "Appendix Z: TODO"
.in 3

Elements to consider:

 * Consider metadata against European mandated business languages for 
   B2B transaction negotiation.

 * Is it worth maintaining a requisite progression (linear or arbitrary)
   of transaction status update notifications within the protocol?

     - Any such progression probably makes state handling easier in cases 
       where multicast or broadcast communications paradigms are in use.

         - See TCP congestion 'strong result' statement in guideline #4,
           [ROBUST]

 * Notify [ROBUST] authors of the use of their guidelines, solicit comment.

 * Need to establish one or more minimum implementation subsets in order
   to simplify deployment within commercial environments.  For example;
   ability to support country specification in ISO format for regulatory
   requirements, ability to support various Transaction Type vocabularies,
   etc.  

     * Ideally there should be some way to summarise a particular
       implementation's capabilities in a concise format, similar to
       the way in which IETF specified protocols such as HTTP support
       Accept-Language headers with language shortlists that MAY
       include general categories ('zh') or more specific ones
       ('zh-tw', 'zh-hk', 'zh-cn').

         * Asset Type Categories
         * Transaction Type Vocabularies

       ... in addition, consider the need to distinguish those features
       of an implementation that are requirements (mandated) vs. supported
       options.

       Note that mandating some support for various specifiers is very
       useful to implementers in the case that the specifier can be
       viewed as hierarchical and upper-layers are from a fixed 
       vocabulary vs. free-form; eg: country, state and city before
       street address.

 * Consider provision of Escrow services as a fundamental use case for
   signature chaining and policy description?

    * Better if this can be avoided as a special use case .. the more
      specific we get, the less likely we are to get things right!

       * Instead view as 2x transactions, one to store something with
         an authority with certain finalization/cancellation parameters,
         the other to confirm/cancel?

.DE
.COPYFULL
