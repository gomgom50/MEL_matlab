function [start] = Start()
setenv('OPENAI_API_KEY','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')
role = "You are a MATLAB expert who only answers with code with no explanation.";
start = chatGPT(model="gpt-3.5-turbo", role=role);
end