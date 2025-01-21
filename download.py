import os
from ftplib import FTP
import lxml.etree as ET
import anthropic

ftp = FTP('oda.ft.dk')
ftp.login()
ftp.cwd('ODAXML/Referat/samling/20241')

samling_list = []
def gather_lines(line):
    samling_list.append(line)

def line_seq(line):
    return int(line.split('_')[1][1:])

ftp.retrlines('NLST', gather_lines)

samling_list.sort(key=line_seq)

latest_file = samling_list[-1]

if not os.path.exists(latest_file):
    print('downloading!')
    with open(latest_file, 'wb') as handle:
        ftp.retrbinary('RETR %s' % latest_file, handle.write)
else:
    print('not download')

dom = ET.parse(latest_file)
print(dom)
xslt = ET.parse('trans.xsl')
transform = ET.XSLT(xslt)
print(transform)
newdom = transform(dom)

client = anthropic.Anthropic()

message = client.messages.create(
    model="claude-3-5-haiku-latest",
    max_tokens=2048,
    temperature=0,
    system="You analyze parliamentary sessions",
    messages=[
        {
            "role": "user",
            "content": [
                {
                    "type": "text",
                    "text": str(newdom)
                },
                {
                    "type": "text",
                    "text": "Summarize today's proceedings. Provide brief descriptions of each proposal. Include the names of the people and their parties who proposed pieces of legislation.It should be understandable for average people with low political knowledge. It is important that the output is only in Danish. the output must be in markdown"
                }
            ]
        }
    ]
)
print(message.content[0].text)

# print(samling_list.split('\n'))
