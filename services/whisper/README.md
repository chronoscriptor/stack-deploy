# Whisper.cpp — Speech-to-Text

**Access:** http://127.0.0.1:8866  
**Image:** onerahmet/openai-whisper-asr-webservice:latest (CPU)  
**Container:** agent-default-whisper

## API Usage

```bash
# Transcribe an audio file
curl -F "audio_file=@recording.mp3" http://127.0.0.1:8866/asr

# With language hint
curl -F "audio_file=@recording.mp3" -F "language=en" http://127.0.0.1:8866/asr

# Get task (transcribe/translate)
curl -F "audio_file=@recording.mp3" -F "task=transcribe" http://127.0.0.1:8866/asr
```

## Config

| Env | Default | Description |
|---|---|---|
| ASR_MODEL | base | Model size (tiny/base/small/medium/large) |
| ASR_LANG | en | Language hint |
| ASR_JSON_RESPONSE | true | Return JSON |

## Network
- Internal: port 9000 → mapped to :8866 on host
- External: agent-shared-net
