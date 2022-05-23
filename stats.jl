function main(nomfichier::String, note_minimale::Float64)
    liste_notes = Vector{Float64}()
    open(nomfichier, "r") do file
        for line in readlines(file)
            if line != ""
                push!(liste_notes, parse(Float64, line))
            end
        end
    end
    sort!(liste_notes)
    moyenne = round(sum(liste_notes)/length(liste_notes), digits=2)
    mediane = liste_notes[round(Int, length(liste_notes)/2, RoundUp)]
    if length(liste_notes) % 2 == 0
        mediane = round(liste_notes[round(Int, length(liste_notes)/2)] +
                liste_notes[round(Int, length(liste_notes)/2)+1],
                digits=3)
    end
    mini = liste_notes[1]
    maxi = liste_notes[end]
    ecarttype = round(sqrt(sum((liste_notes.-moyenne).^2)/length(liste_notes)), digits=2)

    println("Nombre d'étudiants : $(length(liste_notes))")
    println("\tLa moyenne est de $moyenne")
    println("\tLa médiane est de $mediane")
    println("\tLa note minimale est de $mini")
    println("\tLa note maximale est de $maxi")
    println("\tL'écart type est de $ecarttype")

    println()

    if maxi < note_minimale
        println("Nombre d'étudiants ayant eu au moins $note_minimale : 0")
    else
        indice_note_mini = 1
        while liste_notes[indice_note_mini] < note_minimale
            indice_note_mini += 1
        end
        liste_notes_minimale = liste_notes[indice_note_mini:end]
        moyenne = round(sum(liste_notes_minimale)/length(liste_notes_minimale), digits=2)
        mediane = liste_notes_minimale[round(Int, length(liste_notes_minimale)/2, RoundUp)]
        if length(liste_notes_minimale) % 2 == 0
            mediane = round(liste_notes_minimale[round(Int, length(liste_notes_minimale)/2)] +
                    liste_notes_minimale[round(Int, length(liste_notes_minimale)/2)+1],
                    digits=3)
        end
        mini = liste_notes_minimale[1]
        maxi = liste_notes_minimale[end]
        ecarttype = round(sqrt(sum((liste_notes_minimale.-moyenne).^2)/length(liste_notes_minimale)), digits=2)

        println("Nombre d'étudiants ayant eu au moins $note_minimale : $(length(liste_notes_minimale))")
        println("\tLa moyenne des étudiants ayant eu au moins $note_minimale est de $moyenne")
        println("\tLa médiane des étudiants ayant eu au moins $note_minimale est de $mediane")
        println("\tLa note minimale des étudiants ayant eu au moins $note_minimale est de $mini")
        println("\tLa note maximale des étudiants ayant eu au moins $note_minimale est de $maxi")
        println("\tL'écart type des étudiants ayant eu au moins $note_minimale est de $ecarttype")
    end

    return nothing
end

main(ARGS[1][1] in ['/', '~'] ? ARGS[1] : pwd()*"/"*ARGS[1], length(ARGS) >= 2 ? parse(Float64, ARGS[2]) : 4.0)
