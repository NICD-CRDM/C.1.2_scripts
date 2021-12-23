import pandas as pd
import matplotlib.pyplot as plt
import numpy as np
plt.rcParams['font.sans-serif'] = "Arial"
plt.rcParams['font.family'] = "sans-serif"

path = './C1/frequency/'
mutn_file = 'C.1.2_mutation_profile_3sep.tsv'

fig_path = './C1/'

spikepath = './spike_and_references/'
spikefile = 'spike.fa'

# read in spike mutations
df = pd.read_csv(path+mutn_file, sep='\t')

df = df[df.gene == 'S']

# read in canonical mutations
def extract_spike_sequence(path, spike_file):
    with open(path+spike_file) as f:
        data = f.read().split('\n')

    spike = ''
    for line in data[1:]:
        line=line.strip()
        spike = spike + line

    spike = spike.upper()

    # create a dict of posn : canonical aa
    canonical_spike_posns = {}
    i=1
    for aa in spike:
        canonical_spike_posns[i] = aa
        i += 1

    # check to make sure positioned correctly - should be D E N
    print(canonical_spike_posns[80], canonical_spike_posns[484], canonical_spike_posns[501])

    return canonical_spike_posns

# extract all C.1.2 mutations
def extract_c12_mutations(c1_path, c1_file):
    
    df = pd.read_csv(c1_path+c1_file, sep='\t')
    
    # only want spike mutations 
    df = df[df.gene == 'S']

    # extract frequency of each mutation
    pc = df.frequency.to_list()

    # get mutations and positions
    # mutations given as <canonical_aa><position><mutated_aa>
    # want in format above - <position> : <mutated_aa>
    # want position as int
    mutations = {int(mutn[1:-1]) : mutn[-1] for mutn in df.mutation.to_list()}

    # combine frequency and mutation
    c12 = {position : (mutation, frequency) for (position, mutation), frequency in zip(mutations.items(), pc)}
    
    return c12


# not 100% accurate, but does correctly reflect major mutations
# in some cases, other non-defining mutations are included - this was for an initial version of the plot and will not affect the output
alpha = {69:('-', 96.6), 70:('-', 96.6), 144:('-', 94.5), 145:('-', 94.5), 501:('Y', 97.5), 570:('D', 99.0), 614:('G', 99.2), 681:('H', 98.3), 716:('I', 98.5), 982:('A', 98.4), 1118:('H', 99.0)}
beta = {80:('A', 96.3), 215:('G', 92.1), 241:('-', 74.4), 242:('-', 74.4), 243:('-', 74.4), 417:('N', 89.7), 484:('K', 85.9), 501:('Y', 86.6), 614:('G', 97.7), 701:('V', 93.3)}
delta = {19:('R', 98.1), 156:('-', 88.1), 157:('-', 88.1), 158:('G', 88.1), 452:('R', 97.4), 478:('K', 97.6), 614:('G', 99.6), 681:('R', 99.4), 950:('N', 94.7)}
gamma = {18:('F', 97.6), 19:('I', 0), 20:('N', 97.3), 25:('S', 0.1), 26:('S', 97.6), 52:('R', 0), 67:('V', 0.001), 69:('-', 0.3), 70:('-', 0.3), 75:('V', 0.3), 76:('I', 0.1), 80:('A', 0), 95:('I', 0.1), 136:('F', 0), 138:('Y', 96.2), 144:('-', 0.3), 145:('-', 0.3), 156:('D', 0.01), 157:('S', 0.01), 190:('S', 92.5), 215:('G', 0.01), 241:('-', 0.01), 242:('-', 0.01), 243:('-', 0.01), 246:('N', 0), 253:('G', 0.01), 346:('K', 0), 417:('T', 94.9), 449:('H', 0), 452:('R', 0.01), 478:('K', 0.01), 484:('K', 96.1), 490:('S', 0.1), 501:('Y', 96.3), 570:('D', 0.1), 585:('F', 0), 614:('G', 99.1), 655:('Y', 98.5), 677:('H', 0.2), 679:('K', 0.6), 681:('H', 0.1), 701:('V', 0.01), 716:('I', 0.1), 859:('N', 0.01), 888:('L', 0), 950:('H', 0.01), 982:('A', 0.1), 1027:('I', 95.5), 1071:('H', 0), 1118:('H', 0.3), 1176:('F', 97.6)}
eta = {52:('R', 85.1), 67:('V', 95.7), 69:('-', 93.8), 70:('-', 93.8), 75:('V', 0.001), 76:('I', 0), 80:('G', 0.1), 95:('I', 0.9), 136:('F', 0.01), 138:('Y', 0.1), 144:('-', 92.5), 145:('-', 92.5), 156:('D', 1.0), 157:('S', 0.1), 190:('S', 0), 215:('Y', 3.2), 241:('-', 0.1), 242:('-', 0.1), 243:('-', 0.1), 246:('N', 0), 253:('G', 0.01), 346:('K', 0), 417:('N', 0.01), 449:('H', 0), 452:('R', 0.1), 478:('K', 0.01), 484:('K', 97.0), 490:('S', 0), 501:('Y', 0.3), 570:('D', 0.1), 585:('F', 0), 614:('G', 98.8), 655:('Y', 0.01), 677:('H', 97.9), 679:('K', 0.01), 681:('H', 0.01), 701:('V', 0.01), 716:('I', 0), 859:('I', 0.2), 888:('L', 97.0), 950:('H', 0.1), 982:('A', 0.01), 1027:('I', 0.1), 1071:('R', 0.6), 1118:('H', 0.01), 1176:('F', 0.1)}
iota = {5:('F', 75.9), 80:('G', 19.8), 95:('I', 76.8), 144:('-', 21.6), 145:('-', 22.6), 157:('S', 21.6), 190:('S', 0.01), 215:('Y', 0.1), 241:('-', 0.01), 242:('-', 0.01), 243:('-', 0.01), 246:('N', 0), 253:('G', 76.4), 452:('R', 21.7), 484:('K', 90.3), 490:('S', 0.01), 501:('Y', 0.2), 570:('D', 0.1), 585:('F', 0), 614:('G', 99.2), 655:('Y', 0.01), 677:('H', 0.6), 679:('K', 0.01), 681:('H', 0.6), 701:('V', 50.7), 716:('I', 0.2), 859:('N', 22.5), 888:('L', 0), 950:('H', 21.4), 982:('A', 0.1), 1027:('I', 0.1), 1071:('H', 0), 1101:('Q', 0.2), 1118:('H', 0.1), 1176:('F', 0.01)}
kappa = {95:('I', 47.2), 136:('F', 0), 138:('Y', 0.2), 144:('-', 1.8), 145:('-', 1.8), 154:('K', 68.0), 156:('G', 0.1), 157:('-', 0.1), 158:('-', 0.1), 190:('S', 0), 215:('Y', 0.1), 241:('-', 0.01), 242:('-', 0.01), 243:('-', 0.01), 246:('N', 0), 253:('G', 0.01), 346:('K', 0), 417:('N', 0), 449:('H', 0), 452:('R', 94.4), 478:('K', 0.2), 484:('Q', 93.2), 490:('S', 0), 501:('Y', 0.2), 570:('D', 0.1), 585:('F', 0), 614:('G', 98.4), 655:('Y', 0.1), 677:('H', 0.4), 679:('K', 0), 681:('R', 96.7), 701:('V', 0), 716:('I', 0.1), 859:('I', 0.1), 888:('L', 0), 950:('N', 0.1), 982:('A', 0.01), 1027:('I', 0), 1071:('H', 78.4), 1101:('D', 31.4), 1118:('H', 0.1), 1176:('F', 0.1)}
lamda = {75:('V', 93.7), 76:('I', 96.6), 80:('A', 0), 95:('I', 0.1), 136:('F', 0), 138:('H', 0.3), 144:('-', 0.3), 145:('-', 0.3), 156:('G', 0), 157:('-', 0), 158:('-', 0), 190:('S', 0), 215:('G', 0.1), 241:('-', 0), 242:('F', 0.6), 243:('-', 0), 246:('N', 81.4), 247:('-', 82.6), 248:('-', 82.6), 249:('-', 82.6), 250:('-', 82.6), 251:('-', 82.6), 252:('-', 82.6), 253:('-', 82.6), 346:('K', 0), 417:('N', 0), 449:('H', 0), 452:('Q', 98.1), 478:('K', 0), 484:('K', 1), 490:('S', 97.8), 501:('Y', 0.6), 570:('D', 0.01), 585:('F', 0), 614:('G', 98.9), 655:('Y', 0.4), 677:('H', 0.2), 679:('K', 0.1), 681:('H', 1.4), 701:('V', 0.01), 716:('I', 0.7), 859:('N', 90.6), 888:('L', 0), 950:('N', 0.2), 982:('A', 0.1), 1027:('I', 0), 1071:('H', 0), 1118:('H', 0), 1176:('F', 0)}
mu = {95:('I', 93.4), 136:('G', 0), 144:('S', 79.3), 145:('N', 83.5), 156:('G', 0.2), 190:('S', 0), 215:('G', 0), 241:('-', 0), 242:('F', 0), 243:('-', 0), 346:('K', 95.5), 384:('L',0), 440:('K', 0), 449:('N', 0.6), 478:('K', 0), 484:('K', 93.3), 501:('Y', 93.8), 585:('F', 0), 614:('G', 96.7), 655:('Y', 0.1), 679:('K', 0.1), 681:('H', 96.4), 716:('I', 0.7), 859:('N', 0), 879:('N', 0), 936:('N', 0), 950:('N', 88.8), 1101:('Q', 0)}
alpha_sub = {69:('-', 96.6), 70:('-', 96.6), 75:('V', 0.1), 76:('I', 0.1), 80:('Y', 0.1), 95:('I', 0.3), 136:('F', 0), 138:('H', 1.1), 144:('-', 94.5), 145:('-', 94.5), 156:('D', 0.01), 157:('S', 0.01), 190:('S', 0.01), 215:('Y', 0.1), 241:('-', 0.01), 242:('-', 0.01), 243:('S', 0.1), 246:('N', 0), 253:('G', 0.1), 346:('K', 0), 417:('N', 0.02), 449:('S', 0.1), 452:('R', 0.1), 478:('I', 0.1), 484:('K', 100.0), 490:('S', 0.4), 501:('Y', 97.5), 570:('D', 99.0), 585:('F', 0), 614:('G', 99.2), 655:('Y', 0.1), 677:('H', 0.4), 679:('K', 0), 681:('H', 98.3), 701:('V', 0.5), 716:('I', 98.5), 859:('I', 0.01), 888:('L', 0), 950:('N', 0.01), 982:('A', 98.4), 1027:('I', 0), 1071:('H', 0), 1118:('H', 99.0), 1176:('F', 0.2)}
beta_sub = {18:('F', 95.0), 80:('A', 96.3), 215:('G', 92.1), 241:('-', 74.4), 242:('-', 74.4), 243:('-', 74.4), 417:('N', 89.7), 484:('K', 85.9), 501:('Y', 86.6), 614:('G', 97.7), 701:('V', 93.3)}
delta_sub = {19:('R', 98.1), 70:('F', 80), 142:('D', 57.8), 156:('-', 88.1), 157:('-', 88.1), 158:('G', 88.1), 222:('V',90), 258:('L', 90), 452:('R', 97.4), 478:('K', 97.6), 614:('G', 99.6), 681:('R', 99.4), 950:('N', 94.7)}
gamma_sub = {18:('F', 97.6), 19:('I', 0), 20:('N', 97.3), 25:('S', 0.1), 26:('S', 97.6), 52:('R', 0), 67:('V', 0.001), 69:('-', 0.3), 70:('-', 0.3), 75:('V', 0.3), 76:('I', 0.1), 80:('A', 0), 95:('I', 0.1), 136:('F', 0), 138:('Y', 96.2), 144:('-', 0.3), 145:('-', 0.3), 156:('D', 0.01), 157:('S', 0.01), 190:('S', 92.5), 215:('G', 0.01), 241:('-', 0.01), 242:('-', 0.01), 243:('-', 0.01), 246:('N', 0), 253:('G', 0.01), 346:('K', 0), 417:('T', 94.9), 449:('H', 0), 452:('R', 0.01), 478:('K', 0.01), 484:('K', 96.1), 490:('S', 0.1), 501:('Y', 96.3), 570:('D', 0.1), 585:('F', 0), 614:('G', 99.1), 655:('Y', 98.5), 677:('H', 0.2), 679:('K', 0.6), 681:('H', 0.1), 701:('V', 0.01), 716:('I', 0.1), 859:('N', 0.01), 888:('L', 0), 950:('H', 0.01), 982:('A', 0.1), 1027:('I', 95.5), 1071:('H', 0), 1118:('H', 0.3), 1176:('F', 97.6)}

spike = extract_spike_sequence(spikepath, spikefile)
c12 = extract_c12_mutations(path, mutn_file)
print(c12)

# combine variants 
variants = [c12, beta, alpha, alpha_sub, gamma, delta, kappa, eta, iota, lamda, mu]
variant_names = ['C.1.2', 'Beta', 'Alpha', 'Alpha+E484K', 'Gamma', 'Delta', 'Kappa', 'Eta', 'Iota', 'Lambda', 'Mu']

# plot C.1.2 shared and unique mutations, coloured by freq
def plot_colour_by_clade(fig_path, list_varnts, list_varnt_names):
    #956eba - minor shade when two
    #8a5cb5 - minor shade when three
    nc_colours = {'Beta': '#4750E4', 'Alpha': '#4A83E9', 'Alpha+E484K':'#5b90eb',
              'Delta': '#71C3AD', 'Delta+K417N':'#83c7b5', 'Kappa': '#8FD286',
              'Eta': '#D7D452', 'C.1.2':'#62269e', 'minor':'#8a5cb5', 'less':'#b095c9', 'Lambda':'#FF6C34',
              'Gamma': '#59ABD4', 'Iota': '#FFA33D', 'Mu':'#F82D28'}

    posns = [posn for posn in c12.keys()]

    # get canonical aas for mutated posns (needed for xlabels)
    canonical_labels = [aa+str(posn) for posn, aa in spike.items() if posn in posns]
    
    # plot 
    fig, ax = plt.subplots(figsize=(10, 4))
    num_variants = len(list_varnts)
    plot_length = len(posns)
    for idx, variant in enumerate(list_varnts):
        # each variant will cover all possible positions, each restart at beginning
        start = 0
        top = num_variants - idx
        bottom = top - 1
        for position in posns:
            end = start + 1
            if position in variant:
                mutant = variant[position][0]
                frequency = variant[position][1]
                if list_varnt_names[idx] == 'C.1.2':
                    if frequency < 5:
                        ax.fill_between([start, end], [top, top], [bottom, bottom], 
                            color=nc_colours['less'], linewidth=0)  # cm range 0:1 
                        ax.text(start+0.5, bottom+0.5, mutant, fontsize=8,
                            color='white', horizontalalignment='center', verticalalignment='center')
                    elif frequency < 50:
                        ax.fill_between([start, end], [top, top], [bottom, bottom], 
                            color=nc_colours['minor'], linewidth=0)  # cm range 0:1 
                        ax.text(start+0.5, bottom+0.5, mutant, fontsize=8,
                            color='white', horizontalalignment='center', verticalalignment='center')
                    else:
                        ax.fill_between([start, end], [top, top], [bottom, bottom], 
                            color=nc_colours[list_varnt_names[idx]], linewidth=0)  # cm range 0:1 
                        ax.text(start+0.5, bottom+0.5, mutant, fontsize=8,
                            color='white', horizontalalignment='center', verticalalignment='center')
                else:
                    if frequency >= 50:
                        ax.fill_between([start, end], [top, top], [bottom, bottom], 
                            color=nc_colours[list_varnt_names[idx]], linewidth=0)  # cm range 0:1 
                        ax.text(start+0.5, bottom+0.5, mutant, fontsize=8,
                            color='black', horizontalalignment='center', verticalalignment='center')
            #else:
            #    ax.fill_between([start, end], [top, top], [bottom, bottom], color='white') 
            start += 1

    ax.set_xticks((np.arange(0.5,plot_length+0.5)))  # need enough ticks for all labels
    ax.set_xticklabels(canonical_labels, rotation=90)
    ax.set_xlim(0,plot_length)
    ax.set_xlabel('Spike mutations')

    ax.set_yticks([i+0.5 for i in range(num_variants)])  # need enough ticks for all labels
    ax.set_yticklabels(reversed(list_varnt_names))
    ax.set_ylim(0,num_variants)
    ax.set_ylabel('Variant')

    ax.spines['right'].set_visible(False)
    ax.spines['left'].set_visible(False)

    plt.tight_layout()
    plt.savefig(fig_path+'C.1.2_threeshades_publish.pdf', dpi=400)
    plt.show()
    

plot_colour_by_clade(fig_path, variants, variant_names)