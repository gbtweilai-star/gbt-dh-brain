# dh_brain

**One capability bit from GBT V8, packaged standalone.** No. 28 of 341,
`creation` domain (Creation).

<p>
<img alt="python" src="https://img.shields.io/badge/python-3.9%2B-blue">
<img alt="license" src="https://img.shields.io/badge/license-MIT-green">
<img alt="deps" src="https://img.shields.io/badge/runtime%20dependencies-0-brightgreen">
</p>

> 数字人本体（只读能力位·2026-10-08 主人点名「元数据没接入」补齐）：把她（数字人）的**元数据经统一门暴露**——op=status/spec/actions/voice/metadata/health。op 一律**现读单一真源**（state/digital-human-rig.json / digital-human.json / dh_status_audit.json / voice-control-route.json / voicestudio_acceptance.json / projects/digital-human/out/*.json），**不复制第二份**；读不到如实报**未探测**（不折绿）；**零写面**（不改 rig/不渲染/不刷页/不记账）⇒ 读类直连，**无需 policy 条目**

That description is copied verbatim from the registry. `tests/test_spec.py` pins it,
so documentation drift fails the build instead of shipping quietly.

## What this package actually is

It is the **contract** for one capability: its name, its parameters, the values it
accepts, and whether it can change state that cannot be restored. It is not the
implementation — that lives in the runtime this bit was extracted from.

So `run()` goes through a narrow `Backend` protocol, and the default backend is a
stub that **says so**:

```
status="validated"   backend="stub"   data={"executed": false}
```

Never `status="ok"`. A stub that reports success is worse than no stub, because the
caller stops looking for the real thing.

## Install

```bash
git clone https://github.com/gbtweilai-star/gbt-dh-brain.git
cd gbt-dh-brain
python -m pip install -e ".[dev]"
```

## Use

```bash
python -m gbt_dh_brain info                  # capability card
python -m gbt_dh_brain spec --json           # machine-readable contract
python -m gbt_dh_brain check --payload '{}'
python -m gbt_dh_brain run   --payload '{}'
```

Real `info` output from this machine:

```text
dh_brain  (creation)  v1.0.0
----------------------------------------
数字人本体（只读能力位·2026-10-08 主人点名「元数据没接入」补齐）：把她（数字人）的**元数据经统一门暴露**——op=status/spec/actions/voice/metadata/health。op 一律**现读单一真源**（state/digital-human-rig.json / digital-human.json / dh_status_audit.json / voice-control-route.json / voicestudio_acceptance.json / projects/digital-human/out/*.json），**不复制第二份**；读不到如实报**未探测**（不折绿）；**零写面**（不改 rig/不渲染/不刷页/不记账）⇒ 读类直连，**无需 policy 条目**

gated      : False
external   : False
multi-op   : True
params     : (none)
values     : status, spec, actions, voice, metadata, health
```

Wire a real implementation:

```python
from gbt_dh_brain import run

class MyBackend:
    name = "my-backend"
    def invoke(self, cap, payload):
        return {"cap": cap, "handled": sorted(payload)}

result = run({}, backend=MyBackend())
assert result.status == "ok"
```

## Parameters

| name | required | notes |
|---|---|---|
| — | no | the registry declares no required parameters |

Registry hint (`params_hint`): (empty)

**注册表登记的取值 / 子动作（6 个）**：`status`、`spec`、`actions`、`voice`、`metadata`、`health`

Types are deliberately absent: the registry does not declare them, and an invented
type is worse than no type, because callers believe it.

## Boundaries

- Not gated: the registry marks this bit `safe: true`.
- No external service dependency declared.
- Multi-op (`multi_op: true`): several sub-actions share one name — read `op` before calling.
- No implementation ships here. Bring a backend; the protocol is one method.

## What this is not

Not a wrapper around a hosted API. Not a model. Not a promise that calling it does
anything on its own. It is the typed seam plus the validation, which is the part that
stays correct even when the implementation changes.

## Tests

```bash
python -m pytest
```

```text
20 passed, 3 skipped in 0.16s
```

## Provenance

| field | value |
|---|---|
| capability | `dh_brain` |
| domain | `creation` |
| handler | `dh_brain` |
| safe | `True` (gated = `False`) |
| external | `False` |
| atlas page | [creation/dh_brain](https://github.com/gbtweilai-star/gbt-caps/blob/main/caps/creation/dh_brain.md) |
| full index | [https://github.com/gbtweilai-star/gbt-caps](https://github.com/gbtweilai-star/gbt-caps) |

The parent README says 348 capabilities; an AST pass over the registry enumerates
`341 + 0 unimplemented + 0 disabled = 341`. The extra 7 are historical duplicates.
Numbering here follows 341 and matches the `gbt-caps` index one-to-one.

## License

MIT.
