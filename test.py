import Levenshtein

print Levenshtein.ratio('atggca---------gtgtggcaatcggcacat'.replace('-',''),
                          'atggca---------gtgtggcaatcggcacat'.replace('-','')) * 100

print Levenshtein.ratio('atggca---------gtgtggcaatcggcacat'.replace('-',''),
                          'atggca---------gtgtggcaatcggcacaa'.replace('-','')) * 100
