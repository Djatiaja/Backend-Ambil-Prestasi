export type CreateQuizInput = {
    title: string;
    description: string;
    max_attempts: number;
    time_limit: number;
    passing_grade: number;
    xp: number;
    materialId: number;
};

export type UpdateQuizInput = Partial<CreateQuizInput>;

export type CreateQuestionInput = {
    question: string;
    type: "MultipleChoice" | "TrueFalse" | "Essay";
    points: number;
    answers?: { answer: string; is_correct: boolean }[];
};

export type UpdateQuestionInput = Partial<CreateQuestionInput>;

export type StartQuizAttemptInput = {
    quizId: number;
};

export type SaveAnswerInput = {
    attemptId: number;
    questionId: number;
    answer?: string;
    filePath?: string;
    selectedAnswerIds?: number[];
};

export type SubmitQuizInput = {
    attemptId: number;
};

export type GetAttemptResultInput = {
    attemptId: number;
};