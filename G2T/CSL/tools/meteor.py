import sys
import nltk
nltk.download('wordnet')
nltk.download('omw-1.4')

if __name__ == "__main__":
    pred_path = sys.argv[1]
    data_path = sys.argv[2]
    with open(pred_path, "r") as file:
        pred = file.readlines()

    with open(data_path, "r") as file:
        target = file.readlines()
    # pred = [ i.split(" ") for i in pred]
    # target = [ i.split(" ") for i in target]
    scores = [nltk.meteor([t.lower().split(" ")], p.lower().split(" ")) for t,p in zip(target, pred)]
    print(sum(scores)/len(scores))
