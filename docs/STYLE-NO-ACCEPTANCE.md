# Marketing-surface style rule — no acceptance / future-contract / commitment language

> Source of truth for marketing-surface copy. Every page in this repo must follow this rule. Counsel and CEO have approved this rule for the v1.1 remediation pass.

The website is a marketing surface. It is not a customer agreement, a term of a customer agreement, a representation about a customer agreement, or a promise of any specific delivery date. The customer agreement applicable to a given engagement is the place where commitments live. The website is the place where the company describes — at a category level — what the commercial product is being built to be.

## Banned phrasing patterns

| Banned pattern | Safe replacement |
|---|---|
| `AgenticMem accepts liability` / `accepts that liability under contract` / `named liability acceptance` | Delete entirely. Do not replace with anything liability-flavored. If the surrounding context needs to acknowledge counterparty risk, describe the question abstractly: *"Buyers in regulated environments ask who the named operational counterparty for a deployment is, what their security posture is, and who is reachable under process."* Then direct specifics to the customer agreement. |
| `AgenticMem will sign BAAs` / `We sign BAAs` / `AgenticMem will execute Business Associate Agreements` | *"HIPAA Business Associate Agreement scope where applicable to a customer engagement; specific terms set out in the customer agreement applicable to that engagement."* |
| `AgenticMem will offer customer agreements that define those commitments — subject to liability caps, exclusions, the insurance program then in effect, and applicable law` | *"The specific terms of any AgenticMem commercial engagement are matters for the customer agreement applicable to that engagement, not for this document."* Do not enumerate terms even when disclaimed. |
| `defined contractual commitments` / `contractual commitments` / `counterparty obligations` | `customer-agreement scope` / `commercial customer-agreement scope` / `counterparty operations` |
| `liability concentration` / `you carry liability` | `single-point exposure` / `your organization is operationally exposed` |
| `Insurance program will be bound prior to commercial launch` / `Carrier and limits will be disclosed at engagement under NDA, sized to the deployment and tier` | *"Targeted to be in place prior to commercial launch. Any carrier and limits applicable to a given engagement are matters for the customer agreement applicable to that engagement; not disclosed in this document."* |
| `Severity-tiered SLAs defined in the customer agreement` (when used as a feature claim on a marketing surface) | *"Any response targets applicable to a given engagement are specified in the customer agreement applicable to that engagement."* |
| `AgenticMem provides technical evidence and personnel familiar with the system` (categorical present-tense) | *"The AgenticMem commercial product is being built to make technical evidence and personnel familiar with the system available within the scope of a customer engagement."* |
| `AgenticMem is accepting [N] design partners` | *"AgenticMem is reviewing inquiries for up to [N] design-partner engagements."* |
| `binding form of the open-source commitment` / `the contractual backbone of the open-source promise` | *"the open-source-license posture of ai-memory™"* |
| `Contributions accepted under DCO` | *"Contributions are received under the Developer Certificate of Origin (DCO)."* |
| `AgenticMem will sponsor FedRAMP` / `sponsor authorization` (categorical) | *"AgenticMem is being built to pursue FedRAMP authorization through the sponsoring-agency process"* or *"FedRAMP authorization is on the AgenticMem charter roadmap."* |
| `AgenticMem will fill that position` / `AgenticMem fills that position` (categorical) | *"The AgenticMem commercial product is being built to occupy that position at and after commercial launch (Q3 2026), with terms of any specific engagement set out in the customer agreement applicable to that engagement."* |
| `the OSS Permanence Pledge is published at github.com/...` (when not yet there) | *"An OSS Permanence Pledge describing the open-source-license posture is to be published at github.com/..."* — keep this phrasing until the file actually exists at the URL, then switch back to present-tense. |

## General rule

Any sentence whose subject is `AgenticMem` and whose verb is `will` + a verb of legal commitment (sign, execute, accept, agree to, undertake, guarantee, warrant, indemnify, hold harmless, be responsible for, be obligated to) is banned.

**Restructure** to make the customer agreement the subject (*"The customer agreement applicable to a given engagement sets out [item]"*) or to make the product the subject and the verb a capability description (*"The AgenticMem commercial product is being built to [capability]"*).

## Why

A marketing surface that uses categorical commitment language can be construed as a unilateral offer or as a representation that induces reliance. The customer agreement is the instrument that defines commitments. The marketing surface describes capability and direction. Keeping the two surfaces clean of each other's language is a discipline that protects the company and the customer.

## Application

This rule applies to every page in the website repo. New copy must pass a lint of the banned-pattern table before merge. The verification checks at the bottom of `AgenticMem-Website-Execution-Prompt-v1.1.md` enforce a grep-level subset of these patterns at PR time.
