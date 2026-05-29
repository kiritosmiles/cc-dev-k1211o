# TASK-{YYYYMMDD}-{序号}: {任务标题}

<!-- 这是任务文件模板。orchestrator 在用户确认方案后按此格式创建。 -->

## Meta
- **type**: feature / bug-fix / refactor / review / qa
- **owner**: {agent-name}
- **priority**: critical / high / medium / low
- **status**: pending / in-progress / in-review / in-qa / done / blocked
- **depends_on**: []
- **parallel**: true/false
- **created**: {YYYY-MM-DD}

## Scope
- {具体要做什么}

## Target Files
- {涉及的文件路径}

## Acceptance
- {验收条件，可测试的 checklist}

## Result
<!-- 执行 agent 完成后填写 -->
- **outcome**: pass / fail / blocked
- **summary**: {一句话总结}
- **changed_files**: {实际修改的文件列表}

## Review
<!-- reviewer agent 填写审查结论和问题清单 (PASS / FAIL) -->

## QA Result
<!-- qa agent 填写验证结果 (PASS / FAIL) -->
